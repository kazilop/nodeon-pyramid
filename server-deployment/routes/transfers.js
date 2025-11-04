const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// POST /api/transfers/ndn - Перевод NDN
router.post('/ndn', async (req, res) => {
  try {
    const { from_telegram_id, to_user_id, amount } = req.body;
    
    console.log(`💰 Transfer NDN: ${amount} from ${from_telegram_id} to user ${to_user_id}`);

    if (!from_telegram_id || !to_user_id || !amount) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing required fields' 
      });
    }

    if (amount <= 0) {
      return res.status(400).json({ 
        success: false, 
        error: 'Amount must be positive' 
      });
    }

    // Получаем данные отправителя
    const { data: fromUser, error: fromUserError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', from_telegram_id)
      .single();

    if (fromUserError) {
      console.error('From user fetch error:', fromUserError);
      return res.status(404).json({ error: 'Sender not found' });
    }

    // Получаем данные получателя
    const { data: toUser, error: toUserError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('id', to_user_id)
      .single();

    if (toUserError) {
      console.error('To user fetch error:', toUserError);
      return res.status(404).json({ error: 'Recipient not found' });
    }

    // Проверяем баланс отправителя
    if (fromUser.balance_ndn < amount) {
      return res.status(400).json({ 
        success: false, 
        error: 'Insufficient balance' 
      });
    }

    // Выполняем перевод
    const fromNewBalance = fromUser.balance_ndn - amount;
    const toNewBalance = toUser.balance_ndn + amount;

    // Обновляем баланс отправителя
    const { error: fromUpdateError } = await supabase
      .from('nodeon_users')
      .update({ balance_ndn: fromNewBalance })
      .eq('id', fromUser.id);

    if (fromUpdateError) {
      console.error('From user update error:', fromUpdateError);
      return res.status(500).json({ error: 'Failed to update sender balance' });
    }

    // Обновляем баланс получателя
    const { error: toUpdateError } = await supabase
      .from('nodeon_users')
      .update({ balance_ndn: toNewBalance })
      .eq('id', toUser.id);

    if (toUpdateError) {
      console.error('To user update error:', toUpdateError);
      return res.status(500).json({ error: 'Failed to update recipient balance' });
    }

    // Создаем транзакции
    const now = new Date().toISOString();

    // Транзакция отправителя
    const { error: fromTransactionError } = await supabase
      .from('nodeon_transactions')
      .insert({
        user_id: fromUser.id,
        type: 'transfer_sent',
        amount_ndn: -amount,
        description: `Transfer to ${toUser.username || toUser.first_name}`,
        created_at: now
      });

    // Транзакция получателя
    const { error: toTransactionError } = await supabase
      .from('nodeon_transactions')
      .insert({
        user_id: toUser.id,
        type: 'transfer_received',
        amount_ndn: amount,
        description: `Transfer from ${fromUser.username || fromUser.first_name}`,
        created_at: now
      });

    if (fromTransactionError || toTransactionError) {
      console.error('Transaction errors:', { fromTransactionError, toTransactionError });
    }

    res.json({
      success: true,
      message: 'Transfer completed successfully',
      from_new_balance: fromNewBalance,
      to_new_balance: toNewBalance
    });

  } catch (error) {
    console.error('Transfer error:', error);
    res.status(500).json({ error: 'Failed to process transfer' });
  }
});

module.exports = router;


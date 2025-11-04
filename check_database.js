const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function checkDatabase() {
  console.log('🔍 Checking database structure...\n');
  
  try {
    // Check users table
    console.log('1. USERS TABLE:');
    const { data: users, error: usersError } = await supabase
      .from('nodeon_users')
      .select('*')
      .limit(3);
    
    if (usersError) {
      console.log('❌ Users error:', usersError.message);
    } else {
      console.log('✅ Users data:', JSON.stringify(users, null, 2));
    }
    
    // Check transactions table
    console.log('\n2. TRANSACTIONS TABLE:');
    const { data: transactions, error: transError } = await supabase
      .from('nodeon_transactions')
      .select('*')
      .limit(3);
    
    if (transError) {
      console.log('❌ Transactions error:', transError.message);
    } else {
      console.log('✅ Transactions data:', JSON.stringify(transactions, null, 2));
    }
    
    // Check miner data table
    console.log('\n3. MINER DATA TABLE:');
    const { data: minerData, error: minerError } = await supabase
      .from('nodeon_miner_data')
      .select('*')
      .limit(3);
    
    if (minerError) {
      console.log('❌ Miner data error:', minerError.message);
    } else {
      console.log('✅ Miner data:', JSON.stringify(minerData, null, 2));
    }
    
    // Check specific user with PRO status
    console.log('\n4. USER 5 (PRO STATUS):');
    const { data: user5, error: user5Error } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('id', 5)
      .single();
    
    if (user5Error) {
      console.log('❌ User 5 error:', user5Error.message);
    } else {
      console.log('✅ User 5 data:', JSON.stringify(user5, null, 2));
    }
    
    // Check referrals for user 5
    console.log('\n5. REFERRALS FOR USER 5:');
    const { data: referrals, error: refError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('inviter_id', 5);
    
    if (refError) {
      console.log('❌ Referrals error:', refError.message);
    } else {
      console.log('✅ Referrals count:', referrals.length);
      console.log('Referrals data:', JSON.stringify(referrals, null, 2));
    }
    
  } catch (error) {
    console.log('❌ General error:', error.message);
  }
}

checkDatabase();












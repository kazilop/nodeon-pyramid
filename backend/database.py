from sqlalchemy import create_engine, Column, Integer, String, Boolean, DateTime, Text, ForeignKey, Numeric
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship
from datetime import datetime
from config import settings

engine = create_engine(settings.database_url)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

class User(Base):
    __tablename__ = "nodeon_users"
    
    id = Column(Integer, primary_key=True, index=True)
    telegram_id = Column(Integer, unique=True, index=True, nullable=False)
    username = Column(String, nullable=True)
    first_name = Column(String, nullable=True)
    last_name = Column(String, nullable=True)
    balance_ndn = Column(Numeric(10, 2), default=0)
    is_pro = Column(Boolean, default=False)
    referral_link = Column(String, unique=True, nullable=True)
    inviter_id = Column(Integer, ForeignKey("users.id"), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    inviter = relationship("User", remote_side=[id], backref="referrals")
    transactions = relationship("Transaction", back_populates="user")
    referral_stats = relationship("ReferralStats", back_populates="user")

class Transaction(Base):
    __tablename__ = "nodeon_transactions"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("nodeon_users.id"), nullable=False)
    type = Column(String, nullable=False)  # buy_ndn, withdraw_ndn, referral_reward, developer_fee, pro_purchase
    amount_ndn = Column(Numeric(10, 2), nullable=False)
    amount_stars = Column(Numeric(10, 2), nullable=True)
    description = Column(Text, nullable=True)
    referral_level = Column(Integer, nullable=True)  # Для реферальных наград
    created_at = Column(DateTime, default=datetime.utcnow)
    
    # Relationships
    user = relationship("User", back_populates="transactions")

class ReferralStats(Base):
    __tablename__ = "nodeon_referral_stats"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("nodeon_users.id"), nullable=False)
    level = Column(Integer, nullable=False)  # Уровень реферала (1-7)
    total_referrals = Column(Integer, default=0)
    total_earnings = Column(Numeric(10, 2), default=0)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = relationship("User", back_populates="referral_stats")

class PaymentRequest(Base):
    __tablename__ = "nodeon_payment_requests"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("nodeon_users.id"), nullable=False)
    amount_ndn = Column(Numeric(10, 2), nullable=False)
    amount_stars = Column(Numeric(10, 2), nullable=False)
    status = Column(String, default="pending")  # pending, approved, rejected
    created_at = Column(DateTime, default=datetime.utcnow)
    processed_at = Column(DateTime, nullable=True)
    
    # Relationships
    user = relationship("User")

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

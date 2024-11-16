'use client'
import React, { useEffect, useState } from 'react';
import contract from '../utils/contract';
import Image from "next/image";

export default function Home() {
  const [stake, setStake] = useState(0);

  useEffect(() => {
    const fetchStake = async () => {
      const stakeAmount = await contract.getStake();
      setStake(stakeAmount);
    };

    fetchStake();
  }, []);
  return (
    <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
      <main className="flex flex-col gap-8 row-start-2 items-center sm:items-start">
        <h1 className="text-5xl font-bold text-center">Welcome to MaLearnThon</h1>
        <div className="flex gap-4 items-center flex-col sm:flex-row">
          <p>Current Stake: {stake}</p>
        </div>
      </main>
      <footer className="row-start-3 flex gap-6 flex-wrap items-center justify-center">
        Learn, stake, and win! 🚀
      </footer>
    </div>
  );
}

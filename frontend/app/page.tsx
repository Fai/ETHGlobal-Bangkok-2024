'use client'
import React, { useEffect, useState } from 'react';
import contract from '../utils/contract';
import Image from "next/image";
import { ethers } from 'ethers';

export default function Home() {
  const [stake, setStake] = useState(0);
  const [deadline, setDeadline] = useState(0);
  const [timeLeft, setTimeLeft] = useState(0);
  const [amount, setAmount] = useState('');
  const [duration, setDuration] = useState('');

  useEffect(() => {
    const fetchStake = async () => {
      const stakeAmount = await contract.getStake();
      setStake(stakeAmount);
    };

    const fetchDeadline = async () => {
      const deadline = await contract.deadline();
      setDeadline(deadline);
    };

    fetchStake();
    fetchDeadline();

    const interval = setInterval(() => {
      const now = Math.floor(Date.now() / 1000);
      setTimeLeft(deadline - now);
    }, 1000);

    return () => clearInterval(interval);
  }, [deadline]);

  const startCourse = async () => {
    const stakeAmount = ethers.utils.parseEther(amount);
    const durationInSeconds = parseInt(duration) * 60; // Convert minutes to seconds
    await contract.startCourse(stakeAmount, durationInSeconds, { value: stakeAmount });
  };

  const finishCourse = async () => {
    await contract.finishCourse();
  };

  return (
    <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
      <main className="flex flex-col gap-8 row-start-2 items-center sm:items-start">
        <h1 className="text-5xl font-bold text-center">Welcome to MaLearnThon</h1>
        <div className="flex gap-4 items-center flex-col min-w-screen">
          <p>Current Stake: {ethers.utils.formatEther(stake)} ETH</p>
          <p>Time Left: {timeLeft > 0 ? `${Math.floor(timeLeft / 60)}m ${timeLeft % 60}s` : 'Deadline passed'}</p>
          <p>Time to Deadline: </p>  
          <div className="bg-blue-600 h-2.5 rounded-full" style={{ width: `${(timeLeft / (deadline - (deadline - timeLeft))) * 100}%` }}></div>
        </div>
        <div className="flex flex-col gap-4">
          <input
            type="text"
            placeholder="Stake Amount (ETH)"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            className="border p-2 rounded"
          />
          <input
            type="text"
            placeholder="Duration (days)"
            value={duration}
            onChange={(e) => setDuration(e.target.value)}
            className="border p-2 rounded flex-row"
          />
          <button onClick={startCourse} className="bg-blue-500 text-white p-2 rounded">Start Course</button>
          <button onClick={finishCourse} className="bg-green-500 text-white p-2 rounded">Finish Course</button>
        </div>
      </main>
      <footer className="row-start-3 flex gap-6 flex-wrap items-center justify-center">
        Learn, stake, and win! 🚀
      </footer>
    </div>
  );
}
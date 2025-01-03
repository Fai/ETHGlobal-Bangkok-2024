import { ethers } from 'ethers';

const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();

const contractAddress = 'YOUR_CONTRACT_ADDRESS';
const contractABI = [
  // Your contract ABI here
];

const contract = new ethers.Contract(contractAddress, contractABI, signer);

export default contract;
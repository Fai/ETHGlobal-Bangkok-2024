%lang starknet

@contract_interface
namespace IERC20 {
    func transfer(recipient: felt, amount: Uint256) -> (success: felt):
    end
}

@storage_var
func owner() -> felt:
end

@storage_var
func stake_amount() -> Uint256:
end

@storage_var
func deadline() -> felt:
end

@storage_var
func participants() -> (felt, felt):
end

@storage_var
func stakes(address: felt) -> Uint256:
end

@storage_var
func completed_courses(address: felt) -> felt:
end

@event
func CourseStarted(user: felt, stake_amount: Uint256, deadline: felt):
end

@event
func CourseCompleted(user: felt, success: felt):
end

@event
func RewardsDistributed(total_reward: Uint256, reward_per_participant: Uint256):
end

@constructor
func constructor(owner_: felt):
    owner.write(owner_)
    return ()
end

@external
func start_course(stake_amount_: Uint256, deadline_: felt):
    let (caller) = get_caller_address()
    let (stake) = stakes.read(caller)
    assert stake.low == 0, 'You have already staked'
    assert stake_amount_.low > 0, 'Incorrect stake amount'

    stakes.write(caller, stake_amount_)
    let (index) = participants.len()
    participants.write(index, caller)
    stake_amount.write(stake_amount_)
    deadline.write(block_timestamp() + deadline_)

    CourseStarted.emit(caller, stake_amount_, block_timestamp() + deadline_)
    return ()
end

@external
func finish_course():
    let (caller) = get_caller_address()
    let (current_deadline) = deadline.read()
    assert block_timestamp() <= current_deadline, 'Deadline has passed'
    let (stake) = stakes.read(caller)
    assert stake.low > 0, 'No stake found'

    completed_courses.write(caller, 1)
    CourseCompleted.emit(caller, 1)
    return ()
end

@external
func distribute_rewards():
    let (current_deadline) = deadline.read()
    assert block_timestamp() > current_deadline, 'Deadline has not passed yet'

    let (total_reward) = get_balance()
    let mut completed_count = 0

    let (len) = participants.len()
    for i in 0..len {
        let (participant) = participants.read(i)
        let (completed) = completed_courses.read(participant)
        if completed == 1 {
            completed_count += 1
        }
    }

    let mut reward_per_participant = Uint256(0, 0)
    if completed_count > 0 {
        reward_per_participant = total_reward / Uint256(completed_count, 0)
    }

    for i in 0..len {
        let (participant) = participants.read(i)
        let (completed) = completed_courses.read(participant)
        if completed == 1 {
            IERC20.transfer(participant, reward_per_participant)
        }
    }

    RewardsDistributed.emit(total_reward, reward_per_participant)
    return ()
end

func get_balance() -> (balance: Uint256):
    let (balance) = IERC20.balanceOf(contract_address)
    return (balance)
end
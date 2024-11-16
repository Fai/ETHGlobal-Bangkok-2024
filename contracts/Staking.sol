// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StakingContract {
    address public owner;

    struct Participant {
        uint stake;
        bool completed;
    }

    struct Course {
        uint stakeAmount;
        uint deadline;
        address[] participants;
        mapping(address => Participant) participantData;
    }

    Course[] public courses;

    event CourseStarted(uint courseId, address indexed user, uint stakeAmount, uint deadline);
    event CourseCompleted(uint courseId, address indexed user, bool success);

    constructor() {
        owner = msg.sender;
    }

    // Start a new course with staking
    function startCourse(uint _stakeAmount, uint _deadline) public payable {
        require(msg.value == _stakeAmount, "Incorrect stake amount");

        Course storage newCourse = courses.push();
        newCourse.stakeAmount = _stakeAmount;
        newCourse.deadline = block.timestamp + _deadline;
        newCourse.participants.push(msg.sender);
        newCourse.participantData[msg.sender] = Participant(_stakeAmount, false);

        emit CourseStarted(courses.length - 1, msg.sender, _stakeAmount, newCourse.deadline);
    }

    // Finish the course and check if completed on time
    function finishCourse(uint courseId) public {
        Course storage course = courses[courseId];
        require(block.timestamp <= course.deadline, "Deadline has passed");
        require(course.participantData[msg.sender].stake > 0, "No stake found");

        course.participantData[msg.sender].completed = true;
        emit CourseCompleted(courseId, msg.sender, true);
    }

    // Fallback function to receive Ether
    receive() external payable {}
}
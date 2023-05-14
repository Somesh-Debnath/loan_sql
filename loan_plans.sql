create database loan_plans;
use loan_plans;


CREATE TABLE loanplans (
    PlanId INT AUTO_INCREMENT PRIMARY KEY,
    PlanName VARCHAR(30),
    LoanTypeId INT,
    PrincipalAmount INT,
    Tenure INT,
    InterestRate FLOAT,
    InterestAmount INT,
    TotalPayable INT,
    EMI FLOAT,
    PlanValidity DATE,
    PlanAddedOn DATE,
    baseinterest_id INT,
    FOREIGN KEY (baseinterest_id) REFERENCES baseinterest(id),
    CHECK (TotalPayable = PrincipalAmount + InterestAmount),
    CHECK (Tenure < 1000)
);

DELIMITER //

CREATE TRIGGER check_plan_validity
BEFORE INSERT ON loanplans
FOR EACH ROW
BEGIN
    IF NEW.PlanValidity <= CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PlanValidity must be a future date.';
    END IF;
END//

DELIMITER ;


CREATE TABLE loanplanshistory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    updatedDate DATE,
    updateReason VARCHAR(500),
    LoanPlanId INT,
    FOREIGN KEY (LoanPlanId) REFERENCES loanplans(PlanId)
);


create table BaseInterestRates(id int auto_increment primary key,LoanType varchar(25),
BaseInterestRate float);

insert into baseinterestrates(LoanType,BaseInterestRate) values('Home',8.5),('Personal',10),('Medical',7.5),('Vehicle',8.0);
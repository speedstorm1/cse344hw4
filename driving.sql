CREATE TABLE INSURANCECO (
    name varchar(100) PRIMARY KEY,
    phone int
);

CREATE TABLE PERSON (
    int ssn PRIMARY KEY,
    name varchar(50)
);

CREATE TABLE VEHICLE (
    licensePlate varchar(10) PRIMARY KEY,
    insurer varchar(100),
    maxLiability real,
    ssn int,
    year int,
    FOREIGN KEY (insurer) REFERENCES InsuranceCo(name),
    FOREIGN KEY (ssn) REFERENCES Person(ssn)
);

CREATE TABLE DRIVER (
    driverID int,
    ssn int PRIMARY KEY,
    FOREIGN KEY (ssn) REFERENCES PERSON(ssn)
);

CREATE TABLE PROFESSIONALDRIVER (
    medicalHistory varchar(1000),
    ssn int PRIMARY KEY,
    FOREIGN KEY (ssn) REFERENCES DRIVER(ssn)
);

CREATE TABLE NONPROFESSIONALDRIVER (
    ssn int PRIMARY KEY,
    FOREIGN KEY (ssn) REFERENCES DRIVER(ssn)
);

CREATE TABLE CAR (
    make VARCHAR(50),
    licensePlate varchar(10) PRIMARY KEY,
    FOREIGN KEY (licensePlate) REFERENCES VEHICLE(licensePlate)
);

CREATE TABLE TRUCK (
    capacity int,
    driverssn int,
    licensePlate varchar(10) PRIMARY KEY,
    FOREIGN KEY (licensePlate) REFERENCES VEHICLE(licensePlate),
    FOREIGN KEY (driverssn) REFERENCES PROFESSIONALDRIVER(ssn)
);

CREATE TABLE DRIVES (
    driverssn int,
    licensePlate varchar(10),
    FOREIGN KEY (driverssn) REFERENCES NONPROFESSIONALDRIVER(ssn),
    FOREIGN KEY (licensePlate) REFERENCES CAR(licensePlate)
);

-- b) Which relation in your relational schema represents the relationship "insures" in the E/R diagram? Why is that your representation?
-- The relation in my schema representing the "insuring" relationship from the E/R diagram is within the vehicle,
-- where it references the insurance company, as well as contains a maxLiability of the insurance within the vehicle.
-- This is my representation, because each vehicle is mapped to at most one of the insurance companies, and thus
-- we can just store this relationship effectively within the vehicle table, by referring the insurance company name, and
-- storing the maxLiability attribute of the relation within the table. This is more effective than creating a separate table to 
-- just store the insurance relations, as the many-to-one relationship makes it easy for us to do it within the vehicle table.

-- c) Compare the representation of the relationships "drives" and "operates" in your schema, and explain why they are different.
-- We see that "drives" does not have any arrows on its connection, and thus is a many-to-many relationship, such that
-- multiple non-professional drivers can drive the same car, and a non-professional driver can drive more than one car. Thus,
-- we must store this relationship in a separate table, as there is no limit for either the driver or vehicle on the connection
-- and thus must be stored externally without any such quantity restrictions.

-- On the other hand, operates, which is very similar to the "isures" relationship from part b, is a many-to-one relationship where
-- each truck is driven by at most one professional driver, and thus the driver key can be stored in the truck's table to represent
-- the operates relationship. Because we have this restriction on operates being a many-to-one relationship, we don't need to create a 
-- separate table to maintain the relationship. 

-- This is why the representation of the "drives" and "operates" relationships in our schema differ.
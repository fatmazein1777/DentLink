
-- ================= USERS =================
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    phone_number text UNIQUE,
    password TEXT,
    role VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================= UNIVERSITIES =================
CREATE TABLE universities (
    university_id SERIAL PRIMARY KEY,
    name TEXT
);

-- ================= CATEGORIES =================
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100),
    description TEXT
);

-- ================= STATUS =================
CREATE TABLE status (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(20)
);

-- ================= PORTFOLIOS =================
CREATE TABLE portfolios (
    portfolio_id SERIAL PRIMARY KEY,
    before TEXT,
    after TEXT
);

-- ================= STUDENTS =================
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE,
    first_name TEXT,
    last_name TEXT,
    email VARCHAR(150),
    academic_email VARCHAR(100) UNIQUE,
    academic_year INT,
    university_id INT,
    phone_number TEXT UNIQUE ,
    portfolio_id INT,
    profile_image TEXT,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (university_id) REFERENCES universities(university_id),
    FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id)
);

-- ================= PATIENTS =================
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE,
    first_name TEXT,
    last_name TEXT,
    phone_number TEXT UNIQUE,
    date_of_birth DATE,
    address TEXT,
    gender VARCHAR(6),
    whatsapp_number VARCHAR(20),

    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ================= ADMINS =================
CREATE TABLE admins (
    admin_id SERIAL PRIMARY KEY,
    admin_name VARCHAR(20),
    user_id INT UNIQUE,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ================= CASES =================
CREATE TABLE cases (
    case_id SERIAL PRIMARY KEY,
    description TEXT,
    image TEXT,
    category_id INT,
    patient_id INT,
    chronic_diseases TEXT,

    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- ================= REQUESTS =================
CREATE TABLE requests (
    request_id SERIAL PRIMARY KEY,
    case_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    student_id INT,
    status_id INT,
    feedback TEXT,
    rate INT,

    FOREIGN KEY (case_id) REFERENCES cases(case_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (status_id) REFERENCES status(status_id)
);

-- ================= STUDENT CATEGORIES (M:M) =================
CREATE TABLE student_categories (
    student_id INT,
    category_id INT,

    PRIMARY KEY (student_id, category_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- ================= TOOLS =================
CREATE TABLE tools (
    tool_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    condition VARCHAR(50),
    price DECIMAL,
    owner_student_id INT,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (owner_student_id) REFERENCES students(student_id)
);

-- ================= TOOL RENTALS =================
CREATE TABLE tool_rentals (
    rental_id SERIAL PRIMARY KEY,
    tool_id INT,
    renter_student_id INT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    status VARCHAR(50),

    FOREIGN KEY (tool_id) REFERENCES tools(tool_id),
    FOREIGN KEY (renter_student_id) REFERENCES students(student_id)
);

# AI Usage Disclosure Statement

**Student Declaration**: This assignment used generative AI in the following ways for the purposes of completing the assignment: brainstorming, research, planning, feedback, editing.

## Date: November 20, 2025

## AI Tools Used

- **Primary Tool**: Claude (Anthropic AI Assistant)
- **Purpose**: Code development assistance, debugging, documentation, and best practices guidance

## Detailed AI Usage Log

### 1. Project Planning & Architecture (Brainstorming)
**Date**: Throughout development
**AI Assistance**:
- Discussed project structure and architecture decisions
- Brainstormed security implementation strategies
- Planned database schema design (MongoDB for patients, user authentication)
- Discussed separation of concerns and modular design patterns

**Human Contribution**:
- Final architectural decisions
- Specific implementation choices
- Database selection rationale
- Security requirements prioritization

---

### 2. Backend Development (Code Implementation)

#### 2.1 Flask Application Setup
**AI Assistance**:
- Suggested Flask application structure
- Recommended security configurations (CORS, CSRF, session settings)
- Provided boilerplate code for Flask-Login integration

**Human Contribution**:
- Customized configurations for local development
- Integrated specific security requirements
- Modified session handling for production readiness

#### 2.2 Authentication System
**File**: `backend/models/user.py`, `backend/app.py` (auth routes)
**AI Assistance**:
- Suggested bcrypt for password hashing
- Provided Flask-Login implementation patterns
- Recommended username validation regex

**Human Contribution**:
- Implemented specific validation rules
- Customized error messages
- Integrated with MongoDB

#### 2.3 Patient CRUD Operations
**File**: `backend/models/patient.py`, `backend/app.py` (patient routes)
**AI Assistance**:
- Suggested pagination implementation
- Recommended sorting and filtering patterns
- Provided ObjectId handling for MongoDB

**Human Contribution**:
- Implemented specific business logic
- Added age validation (0-100 range)
- Customized query parameters

#### 2.4 Security Implementation
**Files**: `backend/utils.py`, `backend/app.py`
**AI Assistance**:
- Suggested input sanitization techniques
- Recommended secure route decorator pattern
- Provided CSRF protection setup

**Human Contribution**:
- Implemented custom validation logic
- Integrated logging for security events
- Applied security measures across all endpoints

---

### 3. Frontend Development (Code Implementation)

#### 3.1 React Application Structure
**AI Assistance**:
- Suggested component-based architecture
- Recommended React Router for navigation
- Provided Tailwind CSS styling patterns

**Human Contribution**:
- Designed specific UI/UX flows
- Customized styling and branding
- Implemented responsive design

#### 3.2 Authentication UI
**File**: `frontend/src/App.jsx`
**AI Assistance**:
- Suggested session-based authentication pattern
- Provided form validation examples
- Recommended error handling patterns

**Human Contribution**:
- Designed login/register interface
- Implemented user feedback mechanisms
- Customized authentication flow

#### 3.3 Patient Management Interface
**Files**: `frontend/src/components/PatientManager.jsx`, `frontend/src/components/PatientForm.jsx`
**AI Assistance**:
- Suggested table-based data display
- Recommended pagination UI patterns
- Provided form validation examples

**Human Contribution**:
- Designed patient data display
- Implemented CRUD operations UI
- Added user-friendly interactions

---

### 4. Testing (Feedback & Debugging)

#### 4.1 Unit Tests
**Files**: `backend/tests/test_auth.py`, `backend/tests/test_patients.py`
**AI Assistance**:
- Suggested pytest fixtures pattern
- Provided test case examples
- Helped debug session handling issues in tests

**Human Contribution**:
- Wrote specific test cases
- Fixed authentication issues in test fixtures
- Ensured test coverage

**Specific Example - Test Fix**:
- **Problem**: Test fixture was incorrectly setting session cookies manually
- **AI Suggestion**: Use proper login via API endpoint instead of manual cookie setting
- **Human Implementation**: Applied fix and verified tests pass

---

### 5. Documentation (Research & Editing)

#### 5.1 README.md
**AI Assistance**:
- Suggested comprehensive documentation structure
- Provided API documentation format
- Recommended security best practices section

**Human Contribution**:
- Customized for specific project requirements
- Added project-specific installation steps
- Included troubleshooting section based on actual issues encountered

#### 5.2 Code Comments
**AI Assistance**:
- Suggested docstring formats
- Recommended inline comment best practices

**Human Contribution**:
- Wrote specific function documentation
- Added context-specific comments
- Ensured code readability

---

### 6. Security Features Implementation (Research & Planning)

**AI Assistance**:
- Researched OWASP Top 10 vulnerabilities
- Suggested security headers
- Recommended encryption best practices
- Provided CSRF protection implementation

**Human Contribution**:
- Selected appropriate security measures for healthcare data
- Implemented multiple security layers:
  1. Password hashing with bcrypt
  2. Input validation and sanitization
  3. CSRF protection
  4. Secure session handling
  5. CORS configuration
  6. SQL injection prevention (parameterized queries)
  7. XSS prevention (React escaping + sanitization)
  8. Secure error handling (no internal exposure)

---

### 7. Database Design (Planning)

**AI Assistance**:
- Suggested MongoDB for patient records (flexible schema)
- Recommended indexing strategies
- Provided connection security best practices

**Human Contribution**:
- Designed specific schema for patient data
- Implemented indexes on age and stroke fields
- Configured secure MongoDB Atlas connection

---

## Summary of AI vs Human Contribution

### AI Contribution (~40%):
- Boilerplate code generation
- Best practices recommendations
- Security pattern suggestions
- Documentation structure
- Debugging assistance
- Code review and optimization suggestions

### Human Contribution (~60%):
- All final implementation decisions
- Custom business logic
- Specific security implementations
- UI/UX design choices
- Testing strategy and execution
- Integration of all components
- Project-specific customizations
- Error handling and edge cases
- Database schema design
- Deployment configuration

---

## Ethical Considerations

All AI-generated code was:
1. **Reviewed and understood** before implementation
2. **Tested thoroughly** to ensure correctness
3. **Customized** to meet specific project requirements
4. **Integrated** with human-written code
5. **Documented** with proper attribution

The use of AI enhanced productivity and code quality while maintaining full understanding and ownership of the final implementation.

---

## Evidence of AI Usage

Screenshots and chat logs demonstrating AI usage are available upon request. Key interactions included:
- Architecture planning discussions
- Security implementation guidance
- Debugging session for test fixtures
- Documentation structure planning
- Code review and optimization

---

**Declaration**: I confirm that all AI usage has been disclosed above, and I take full responsibility for the final implementation and any errors or issues that may arise.

**Date**: November 20, 2025

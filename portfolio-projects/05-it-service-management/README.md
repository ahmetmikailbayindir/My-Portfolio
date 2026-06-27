# IT Service Management (CST8206)

> Framework documentation, process workflows, and case studies demonstrating ITSM best practices and ITIL foundations.

## 📋 Overview

This repository contains IT Service Management (ITSM) documentation, process analysis, and case studies developed during the CST8206 IT Service Management course at Algonquin College. Content focuses on ITIL framework, incident management, change management, and service delivery best practices.

## 🎯 Content Included

### 1. ITSM Process Documentation
- **Description**: Detailed documentation of core ITSM processes
- **Topics**: Incident, Problem, Change, and Service Request Management
- **Location**: [processes/](processes/)

### 2. Case Studies
- **Description**: Real-world ITSM scenario analysis and solutions
- **Topics**: Service desk optimization, major incident handling
- **Location**: [case-studies/](case-studies/)

### 3. Workflow Diagrams
- **Description**: Visual process flows for ITSM procedures
- **Topics**: Ticket lifecycle, escalation paths, change approval
- **Location**: [workflows/](workflows/)

### 4. Best Practices & Templates
- **Description**: Industry-standard templates and guidelines
- **Topics**: SLAs, KPIs, incident reports, RCA templates
- **Location**: [templates/](templates/)

## 🏗️ ITIL Framework Overview

### Core ITSM Processes Covered

#### 1. Incident Management
**Goal**: Restore normal service operation as quickly as possible

**Key Steps**:
- Incident detection and recording
- Categorization and prioritization
- Investigation and diagnosis
- Resolution and recovery
- Incident closure

**Metrics**: MTTR (Mean Time to Resolve), First Call Resolution Rate

#### 2. Problem Management
**Goal**: Prevent incidents from happening and minimize impact of unavoidable incidents

**Key Steps**:
- Problem identification
- Root Cause Analysis (RCA)
- Known Error Database (KEDB) maintenance
- Workaround implementation
- Permanent solution development

#### 3. Change Management
**Goal**: Ensure changes are recorded, evaluated, approved, and reviewed in a controlled manner

**Key Steps**:
- Request for Change (RFC)
- Change assessment and approval
- Change implementation
- Post-implementation review (PIR)

**Change Types**:
- Standard (pre-approved)
- Normal (requires approval)
- Emergency (expedited process)

#### 4. Service Request Management
**Goal**: Handle user requests for service in an efficient and user-friendly manner

**Examples**:
- Password resets
- Software installation requests
- Access rights requests
- Hardware provisioning

## 📊 Process Workflows

### Incident Management Flow
```
User Reports Issue
        ↓
Service Desk Logs Ticket
        ↓
Categorize & Prioritize
        ↓
    [P1 Critical] → Escalate to Major Incident Team
        ↓
Investigation & Diagnosis
        ↓
Resolution Applied
        ↓
User Confirmation
        ↓
Ticket Closure & Documentation
```

### Change Management Flow
```
Change Request Submitted (RFC)
        ↓
Initial Assessment
        ↓
Change Advisory Board (CAB) Review
        ↓
[Approved?] → Yes → Schedule Change
            → No → Reject/Request More Info
        ↓
Implement Change
        ↓
Post-Implementation Review (PIR)
        ↓
Close Change Record
```

## 📈 Key Performance Indicators (KPIs)

### Service Desk Metrics

| Metric | Description | Target |
|--------|-------------|--------|
| **MTTR** | Mean Time to Resolve | < 4 hours |
| **FCR** | First Call Resolution Rate | > 75% |
| **CSAT** | Customer Satisfaction Score | > 85% |
| **Ticket Backlog** | Number of open tickets | < 50 |
| **SLA Compliance** | % of tickets meeting SLA | > 95% |

### Change Management Metrics

| Metric | Description | Target |
|--------|-------------|--------|
| **Change Success Rate** | % of changes without incidents | > 95% |
| **Emergency Changes** | % of emergency changes | < 10% |
| **CAB Meeting Frequency** | Weekly/Bi-weekly | Weekly |

## 🔍 Case Study Example: Major Incident Response

### Scenario
**Company**: Mid-sized e-commerce platform
**Issue**: Complete website outage during Black Friday
**Impact**: 5000+ customers unable to purchase, $50,000/hour revenue loss

### Response Process

**1. Detection & Escalation (0-5 minutes)**
- Monitoring system alerts service desk
- Ticket automatically logged as P1 Critical
- Major Incident Manager (MIM) notified
- Emergency response team assembled

**2. Initial Assessment (5-15 minutes)**
- MIM opens war room (conference bridge)
- Technical team investigates root cause
- Communications team prepares customer notification
- Management team notified

**3. Diagnosis (15-45 minutes)**
- Database server identified as issue (disk failure)
- Failover to backup server initiated
- Data integrity checks performed

**4. Resolution (45-60 minutes)**
- Traffic redirected to backup infrastructure
- Website functionality restored
- Monitoring confirms normal operations

**5. Post-Incident Review (Next business day)**
- Root Cause Analysis conducted
- Timeline documented
- Lessons learned identified:
  - Improve monitoring for disk health
  - Reduce failover time (currently 30 min → target 5 min)
  - Enhance customer communication templates

### Lessons Learned & Actions
- ✅ Implement proactive SMART monitoring
- ✅ Automate failover procedures
- ✅ Create pre-approved customer communication templates
- ✅ Schedule quarterly disaster recovery drills

## 📝 SLA (Service Level Agreement) Example

### Priority Matrix

| Priority | Description | Response Time | Resolution Target |
|----------|-------------|---------------|-------------------|
| **P1 - Critical** | Complete service outage | 15 minutes | 4 hours |
| **P2 - High** | Major functionality impaired | 1 hour | 8 hours |
| **P3 - Medium** | Minor functionality issue | 4 hours | 2 business days |
| **P4 - Low** | General inquiry/request | 1 business day | 5 business days |

### Escalation Path
```
Level 1: Service Desk (0-30 min)
    ↓ (If unresolved)
Level 2: Technical Support (30 min - 2 hours)
    ↓ (If unresolved)
Level 3: Senior Engineers (2+ hours)
    ↓ (If critical)
Management Escalation (Major Incidents)
```

## 🛠️ Tools Referenced

### ITSM Platforms
- ServiceNow
- Jira Service Management
- Freshservice
- BMC Remedy

### Documentation Tools
- Confluence (knowledge base)
- SharePoint
- Microsoft Teams

### Monitoring Tools
- Nagios
- SolarWinds
- PRTG Network Monitor

## 🎓 What I Learned

### ITSM Concepts
- ITIL v4 framework and principles
- Service lifecycle (Strategy → Design → Transition → Operation → Continual Improvement)
- Difference between incidents, problems, and changes
- Importance of knowledge management
- Root Cause Analysis techniques (5 Whys, Fishbone Diagrams)

### Professional Skills
- Process documentation best practices
- Stakeholder communication
- SLA creation and management
- Metrics and reporting
- Continuous service improvement methodology

### Real-World Application
- How ITSM reduces downtime and costs
- Balancing speed with quality in incident response
- Managing user expectations through SLAs
- Importance of post-incident reviews
- Building a knowledge base for self-service

## 📚 Templates Included

1. **[Incident Report Template](templates/incident-report-template.md)**
2. **[Root Cause Analysis (RCA) Template](templates/rca-template.md)**
3. **[Change Request Form (RFC)](templates/change-request-form.md)**
4. **[SLA Document Template](templates/sla-template.md)**
5. **[Post-Implementation Review Template](templates/pir-template.md)**

## 🏷️ Skills Demonstrated

`ITIL Framework` `Incident Management` `Problem Management` `Change Management` `Service Level Agreements` `Process Documentation` `Root Cause Analysis` `KPI Tracking` `Professional Communication` `IT Operations`

## 👤 About This Project

**Created by**: Ahmet Mikail Bayindir
**Program**: Computer Systems Technician - Networking
**Institution**: Algonquin College
**Course**: CST8206 - IT Service Management

### What I Built

This ITSM documentation framework represents what I learned about managing IT services professionally. I created comprehensive process documentation, case studies, and templates based on ITIL best practices.

### Why This Matters

This coursework showed me how poor incident management can lead to repeated issues and frustrated users. It taught me how to:

- **Structure incident response** instead of reactive firefighting
- **Document problems properly** so they don't keep happening
- **Communicate SLAs clearly** to set realistic expectations
- **Use metrics** to prove service improvement

At **Kelesoglu IT** (2017-2019), we didn't have formal change management - changes were made on the fly, which occasionally broke things. Understanding the ITIL framework showed me why controlled change processes prevent outages.

### Real-World Impact

The major incident case study in this project illustrates a common scenario, such as a file server crashing during a critical period. Having a documented incident response process would help to:
- Reduce resolution time
- Improve communication with stakeholders
- Prevent the same issue from recurring

This isn't just theory - it's how professional IT organizations actually work.

## 📄 License

This project is for educational purposes as part of the CST8206 course curriculum.

---

## 💡 How ITSM Benefits Organizations

- **Reduced Downtime**: Structured incident response minimizes service interruptions
- **Cost Savings**: Proactive problem management prevents recurring issues
- **Improved User Satisfaction**: Clear SLAs set expectations and accountability
- **Better Change Success**: Controlled change process reduces failed deployments
- **Knowledge Retention**: Documentation ensures continuity despite staff turnover
- **Compliance**: Standardized processes support audit requirements

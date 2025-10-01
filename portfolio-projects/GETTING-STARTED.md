# 🚀 Getting Started - Portfolio Setup Guide

This guide will help you customize and publish your technical portfolio to GitHub.

## 📋 Quick Start Checklist

### Step 1: Personalize Your Portfolio
- [ ] Replace `Ahmet Mikail Bayindir` throughout all README files with your actual name
- [ ] Add your email and LinkedIn in the main [README.md](README.md)
- [ ] Update dates in each project (use actual course completion dates)
- [ ] Add your GitHub username to contact section

### Step 2: Add Your Actual Work
- [ ] Replace sample scripts with your actual lab scripts
- [ ] Add Packet Tracer (.pkt) files to networking labs
- [ ] Add screenshots showing your projects running
- [ ] Include your actual PowerShell scripts and configs
- [ ] Add diagrams (use draw.io or Packet Tracer screenshots)

### Step 3: GitHub Repository Setup

#### Option A: Single Repository (Monorepo) - **Recommended for Starting**

1. **Initialize Git Repository:**
   ```bash
   cd portfolio-projects
   git init
   git add .
   git commit -m "Initial commit: Technical portfolio with 5 project categories"
   ```

2. **Create GitHub Repository:**
   - Go to [github.com/new](https://github.com/new)
   - Name it: `technical-portfolio` or `cst-networking-portfolio`
   - Don't initialize with README (we have one)
   - Click "Create repository"

3. **Push to GitHub:**
   ```bash
   git remote add origin https://github.com/YOUR-USERNAME/technical-portfolio.git
   git branch -M main
   git push -u origin main
   ```

4. **Update GitHub Repository Settings:**
   - Add description: "Hands-on technical portfolio: System Administration, Networking, Scripting, and IT Support projects"
   - Add topics: `computer-systems` `networking` `ccna` `system-administration` `portfolio` `powershell` `bash-scripting` `algonquin-college`

#### Option B: Separate Repositories (For Showcasing Specific Skills)

Create individual repos for your top 3-4 projects:

**Example: Linux Scripting Labs**
```bash
cd 01-linux-scripting-labs
git init
git add .
git commit -m "Linux scripting projects: Parity counter, number guess game, calculator"
git remote add origin https://github.com/YOUR-USERNAME/linux-scripting-labs.git
git push -u origin main
```

**Repeat for:**
- `windows-admin-labs`
- `networking-labs`
- `pc-troubleshooting-guides`

### Step 4: Create a Killer GitHub Profile README

Create a repository named `YOUR-USERNAME` (same as your username) with a README.md:

```markdown
# Hi, I'm Ahmet Mikail Bayindir 👋

## 🎓 Computer Systems Technician - Networking Student
**Algonquin College** | Graduating [Month Year]

## 🛠️ Technical Skills
- **Systems**: Windows Server, Linux, Active Directory, PowerShell
- **Networking**: Cisco (VLANs, OSPF, Routing & Switching), Subnetting
- **Scripting**: Bash, PowerShell
- **Tools**: Packet Tracer, VMware, Git

## 📂 Featured Projects
### [Technical Portfolio](https://github.com/YOUR-USERNAME/technical-portfolio)
Comprehensive showcase of 15+ hands-on labs including Windows Server administration, Cisco networking configurations, scripting automation, and IT troubleshooting documentation.

**Highlights:**
- 🐧 Linux Bash scripts with input validation
- 🪟 PowerShell automation (50+ AD users from CSV)
- 🌐 VLAN configuration with inter-VLAN routing
- 🛠️ Professional troubleshooting guides

### [Project 2 Name]
[Brief description]

## 📫 Connect With Me
- LinkedIn: [Your LinkedIn URL]
- Email: your.email@example.com
```

## 🎨 Enhancing Your Portfolio

### Add Screenshots
1. Take clear screenshots of:
   - Scripts running in terminal
   - Packet Tracer topologies
   - PowerShell output showing user creation
   - Windows Server configurations (AD Users and Computers)

2. Save in each project folder as:
   - `screenshots/` directory
   - PNG format preferred
   - Descriptive filenames: `vlan-config-verification.png`

3. Reference in README:
   ```markdown
   ![VLAN Configuration](screenshots/vlan-config-verification.png)
   ```

### Create Network Diagrams
**Tools:**
- [Draw.io](https://draw.io) - Free, professional diagrams
- Cisco Packet Tracer - Export topology images
- Microsoft Visio (if available)

**What to diagram:**
- Active Directory OU structure
- Network topologies with IP addresses
- VLAN designs
- Email infrastructure (Exchange Server setup)

### Add Your Actual Files
- **Bash scripts**: Copy from your CST8245 labs
- **PowerShell scripts**: Export your actual working scripts
- **Packet Tracer files**: Include .pkt files
- **Config exports**: Switch and router configs

## 🔍 Portfolio Quality Checklist

### Documentation Quality
- [ ] No spelling or grammar errors
- [ ] All code is properly commented
- [ ] READMEs are complete (not just templates)
- [ ] Screenshots are clear and relevant
- [ ] Technical explanations are accurate

### Professionalism
- [ ] Consistent formatting across all docs
- [ ] Professional tone (not casual)
- [ ] Code follows best practices
- [ ] No placeholder text like `Ahmet Mikail Bayindir`

### Completeness
- [ ] Each project has a README
- [ ] Each project has working code/configs
- [ ] Main README has links to all projects
- [ ] Contact information is up-to-date

## 📈 Portfolio Marketing Tips

### 1. Pin Your Best Projects on GitHub
- Go to your GitHub profile
- Click "Customize your pins"
- Select your top 4-6 repositories
- These show prominently to profile visitors

### 2. Use on Your Resume
```
PROJECTS
Technical Portfolio - github.com/username/technical-portfolio
• Developed 15+ hands-on projects demonstrating system administration,
  networking, and scripting skills
• Automated Active Directory user creation reducing task time by 98%
• Configured enterprise-level VLAN networks with Cisco equipment
• Documented professional IT troubleshooting procedures for Windows/Linux
```

### 3. Share on LinkedIn
Post about your portfolio:
```
🎉 Excited to share my technical portfolio!

As I near completion of my Computer Systems Technician - Networking
program at Algonquin College, I've compiled my best projects into a
comprehensive GitHub portfolio.

Includes:
✅ Windows Server & Active Directory administration
✅ Cisco networking labs (VLANs, routing protocols)
✅ Bash and PowerShell automation scripts
✅ Professional IT troubleshooting documentation

Check it out: [GitHub link]

#ITCareer #Networking #SystemAdministration #CCNA #AlgonquinCollege
```

### 4. Use in Job Applications
In cover letters:
```
"I've developed hands-on experience with Windows Server administration,
including Active Directory and PowerShell automation, as documented in
my technical portfolio at [GitHub link]. My VLAN configuration lab
demonstrates CCNA-level networking skills directly applicable to this
Network Technician role."
```

## 🎯 Project Priority Guide

**Must Have (Do First):**
1. **Windows Admin Labs** - Shows enterprise skills employers want
2. **Networking Labs** - Demonstrates CCNA knowledge
3. **One complete troubleshooting guide** - Shows documentation ability

**Should Have:**
4. Linux Scripting Labs - Proves coding ability
5. ITSM documentation - Shows process understanding

**Nice to Have:**
6. Additional troubleshooting guides
7. Multiple networking labs
8. Advanced PowerShell scripts

## 📚 Resources for Improvement

### Free Learning Resources
- [Microsoft Learn](https://learn.microsoft.com) - PowerShell, Windows Server
- [Cisco NetAcad](https://netacad.com) - CCNA practice labs
- [Linux Journey](https://linuxjourney.com) - Linux fundamentals

### Portfolio Inspiration
- Search GitHub for: `topic:portfolio topic:networking`
- Look at other CST student portfolios
- Check CCNA project repositories for formatting ideas

### Documentation Best Practices
- [Google Technical Writing Course](https://developers.google.com/tech-writing) - Free
- [Markdown Guide](https://markdownguide.org) - Formatting reference
- [Write the Docs](https://writethedocs.org) - Documentation community

## 🆘 Common Issues & Solutions

### Issue: Git push rejected
**Solution:**
```bash
git pull origin main --rebase
git push origin main
```

### Issue: Files too large (>100MB)
**Solution:**
- Don't commit large files (VMs, ISOs)
- Use `.gitignore` file
- For Packet Tracer files, compress if needed

### Issue: Can't remember Git commands
**Solution:** Bookmark this cheat sheet:
```bash
# Check status
git status

# Add all changes
git add .

# Commit with message
git commit -m "Your message"

# Push to GitHub
git push origin main

# Pull latest changes
git pull origin main
```

## ✅ Final Pre-Publish Checklist

Before sharing your portfolio with employers:

- [ ] All `Ahmet Mikail Bayindir` placeholders replaced
- [ ] Contact information is current
- [ ] No sensitive information (passwords, real company names if from co-op)
- [ ] All links work (test in incognito mode)
- [ ] Code runs without errors
- [ ] Proofread all documentation
- [ ] Screenshots are professional quality
- [ ] Repository has a description and topics on GitHub
- [ ] Main README is comprehensive
- [ ] License file added (MIT or appropriate)

## 🎉 You're Ready!

Once you've completed this checklist, your portfolio will be:
- ✅ Professional and polished
- ✅ Easy for employers to navigate
- ✅ Demonstrating real, practical skills
- ✅ Standing out from other candidates

**Good luck with your job search!**

---

**Need Help?**
- GitHub Documentation: [docs.github.com](https://docs.github.com)
- Markdown Guide: [markdownguide.org](https://markdownguide.org)
- Git Tutorial: [git-scm.com/book](https://git-scm.com/book)

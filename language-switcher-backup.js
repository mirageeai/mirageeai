// Language Switcher for HEXAGON DRAGON Website
// Supports Chinese and English versions

class LanguageSwitcher {
    constructor() {
        this.currentLang = this.detectLanguage();
        this.init();
    }

    // Detect current language from URL or HTML lang attribute
    detectLanguage() {
        const path = window.location.pathname;
        const filename = path.split('/').pop(); // Get the filename from path
        
        if (filename === 'index-zh.html') {
            return 'zh';
        } else if (filename === 'index.html' || filename === '' || path === '/') {
            return 'en';
        }
        return 'en'; // Default to English
    }

    // Initialize language switcher
    init() {
        this.updateLanguageButton();
        this.addLanguageToggle();
        this.setupLanguagePersistence();
    }

    // Update language button text and style
    updateLanguageButton() {
        const langSwitch = document.querySelector('.lang-switch');
        if (langSwitch) {
            if (this.currentLang === 'zh') {
                langSwitch.textContent = 'EN';
                langSwitch.href = 'index.html';
            } else {
                langSwitch.textContent = '中文';
                langSwitch.href = 'index-zh.html';
            }
        }
    }

    // Add language toggle functionality
    addLanguageToggle() {
        const langSwitch = document.querySelector('.lang-switch');
        if (langSwitch) {
            langSwitch.addEventListener('click', (e) => {
                e.preventDefault();
                this.toggleLanguage();
            });
        }
    }

    // Toggle between languages
    toggleLanguage() {
        const currentPath = window.location.pathname;
        let newPath;

        if (this.currentLang === 'zh') {
            // Switch to English
            if (currentPath.includes('index-zh.html')) {
                newPath = currentPath.replace('index-zh.html', 'index.html');
            } else {
                newPath = '/index.html';
            }
        } else {
            // Switch to Chinese
            if (currentPath.includes('index.html')) {
                newPath = currentPath.replace('index.html', 'index-zh.html');
            } else {
                newPath = '/index-zh.html';
            }
        }

        // Smooth transition
        this.fadeOut(() => {
            window.location.href = newPath;
        });
    }

    // Fade out effect before language switch
    fadeOut(callback) {
        const body = document.body;
        body.style.transition = 'opacity 0.3s ease';
        body.style.opacity = '0';
        
        setTimeout(() => {
            if (callback) callback();
        }, 300);
    }

    // Setup language preference persistence
    setupLanguagePersistence() {
        // Save language preference to localStorage
        const langSwitch = document.querySelector('.lang-switch');
        if (langSwitch) {
            langSwitch.addEventListener('click', () => {
                const targetLang = this.currentLang === 'zh' ? 'en' : 'zh';
                localStorage.setItem('preferred-language', targetLang);
            });
        }

        // Restore language preference on page load (only if user explicitly chose)
        const savedLang = localStorage.getItem('preferred-language');
        if (savedLang && savedLang !== this.currentLang && this.isFirstVisit()) {
            // Only redirect if this is not the first visit and user has a preference
            setTimeout(() => {
                this.redirectToPreferredLanguage(savedLang);
            }, 1000);
        }
    }

    // Check if this is the first visit
    isFirstVisit() {
        const hasVisited = localStorage.getItem('has-visited-before');
        if (!hasVisited) {
            localStorage.setItem('has-visited-before', 'true');
            return true;
        }
        return false;
    }

    // Redirect to preferred language
    redirectToPreferredLanguage(targetLang) {
        if (targetLang === 'zh' && this.currentLang === 'en') {
            window.location.href = '/index-zh.html';
        } else if (targetLang === 'en' && this.currentLang === 'zh') {
            window.location.href = '/index.html';
        }
    }

    // Get current language
    getCurrentLanguage() {
        return this.currentLang;
    }

    // Check if current language is Chinese
    isChinese() {
        return this.currentLang === 'zh';
    }

    // Check if current language is English
    isEnglish() {
        return this.currentLang === 'en';
    }
}

// Initialize language switcher when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    window.languageSwitcher = new LanguageSwitcher();
});

// Add language detection for search engines
if (typeof window !== 'undefined') {
    // Add hreflang tags for SEO
    const addHreflangTags = () => {
        const head = document.head;
        
        // Remove existing hreflang tags
        const existingTags = head.querySelectorAll('link[hreflang]');
        existingTags.forEach(tag => tag.remove());

        // Add hreflang tags
        const currentPath = window.location.pathname;
        const baseUrl = window.location.origin;
        
        // Chinese version
        const zhLink = document.createElement('link');
        zhLink.rel = 'alternate';
        zhLink.hreflang = 'zh';
        zhLink.href = baseUrl + '/index-zh.html';
        head.appendChild(zhLink);

        // English version
        const enLink = document.createElement('link');
        enLink.rel = 'alternate';
        enLink.hreflang = 'en';
        enLink.href = baseUrl + '/index.html';
        head.appendChild(enLink);

        // Default language
        const defaultLink = document.createElement('link');
        defaultLink.rel = 'alternate';
        defaultLink.hreflang = 'x-default';
        defaultLink.href = baseUrl + '/index.html';
        head.appendChild(defaultLink);
    };

    // Add hreflang tags when page loads
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', addHreflangTags);
    } else {
        addHreflangTags();
    }
}

// Export for module systems
if (typeof module !== 'undefined' && module.exports) {
    module.exports = LanguageSwitcher;
}

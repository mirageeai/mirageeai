// Fixed Language Switcher for HEXAGON DRAGON Website
// Supports Chinese and English versions

class LanguageSwitcher {
    constructor() {
        this.currentLang = this.detectLanguage();
        this.initialized = false;
        this.init();
    }

    // Detect current language from URL
    detectLanguage() {
        const path = window.location.pathname;
        const filename = path.split('/').pop(); // Get the filename from path
        
        console.log('Path:', path, 'Filename:', filename);
        
        if (filename === 'index-zh.html') {
            return 'zh';
        } else if (filename === 'index.html' || filename === '' || path === '/') {
            return 'en';
        }
        return 'en'; // Default to English
    }

    // Initialize language switcher
    init() {
        if (this.initialized) return;
        
        console.log('Initializing language switcher, current language:', this.currentLang);
        
        this.updateLanguageButton();
        this.addLanguageToggle();
        this.setupLanguagePersistence();
        
        this.initialized = true;
        console.log('Language switcher initialized successfully');
    }

    // Update language button text and style
    updateLanguageButton() {
        const langSwitch = document.querySelector('.lang-switch');
        if (langSwitch) {
            if (this.currentLang === 'zh') {
                langSwitch.textContent = 'EN';
                langSwitch.href = 'index.html';
                console.log('Updated button to EN, linking to index.html');
            } else {
                langSwitch.textContent = '中文';
                langSwitch.href = 'index-zh.html';
                console.log('Updated button to 中文, linking to index-zh.html');
            }
        } else {
            console.warn('Language switch button not found');
        }
    }

    // Add language toggle functionality
    addLanguageToggle() {
        const langSwitch = document.querySelector('.lang-switch');
        if (langSwitch) {
            // Remove existing event listeners
            const newLangSwitch = langSwitch.cloneNode(true);
            langSwitch.parentNode.replaceChild(newLangSwitch, langSwitch);
            
            newLangSwitch.addEventListener('click', (e) => {
                e.preventDefault();
                console.log('Language switch clicked, current lang:', this.currentLang);
                this.toggleLanguage();
            });
            
            console.log('Language toggle event listener added');
        }
    }

    // Toggle between languages
    toggleLanguage() {
        const currentPath = window.location.pathname;
        let newPath;

        console.log('Toggling language from:', this.currentLang, 'Path:', currentPath);

        if (this.currentLang === 'zh') {
            // Switch to English
            if (currentPath.includes('index-zh.html')) {
                newPath = currentPath.replace('index-zh.html', 'index.html');
            } else {
                newPath = '/index.html';
            }
            console.log('Switching to English, new path:', newPath);
        } else {
            // Switch to Chinese
            if (currentPath.includes('index.html')) {
                newPath = currentPath.replace('index.html', 'index-zh.html');
            } else {
                newPath = '/index-zh.html';
            }
            console.log('Switching to Chinese, new path:', newPath);
        }

        // Smooth transition
        this.fadeOut(() => {
            console.log('Redirecting to:', newPath);
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
                console.log('Saved language preference:', targetLang);
            });
        }

        // Restore language preference on page load (only if user explicitly chose)
        const savedLang = localStorage.getItem('preferred-language');
        if (savedLang && savedLang !== this.currentLang && this.isFirstVisit()) {
            console.log('Restoring language preference:', savedLang);
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
            console.log('Redirecting to Chinese version');
            window.location.href = '/index-zh.html';
        } else if (targetLang === 'en' && this.currentLang === 'zh') {
            console.log('Redirecting to English version');
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

    // Debug method
    debug() {
        console.log('=== Language Switcher Debug ===');
        console.log('Current Language:', this.currentLang);
        console.log('Initialized:', this.initialized);
        console.log('Current Path:', window.location.pathname);
        console.log('Language Switch Button:', document.querySelector('.lang-switch'));
        console.log('Local Storage:', {
            'preferred-language': localStorage.getItem('preferred-language'),
            'has-visited-before': localStorage.getItem('has-visited-before')
        });
        console.log('===============================');
    }
}

// Initialize language switcher when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM loaded, initializing language switcher...');
    
    // Wait a bit for all elements to be ready
    setTimeout(() => {
        window.languageSwitcher = new LanguageSwitcher();
        
        // Debug info
        if (window.languageSwitcher) {
            window.languageSwitcher.debug();
        }
    }, 100);
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
        
        console.log('Hreflang tags added for SEO');
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

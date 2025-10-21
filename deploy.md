# Deployment Guide for Alter'D Workshop Website

## Quick Start
1. **Test locally**: `python -m http.server 8000`
2. **Optimize images**: `./optimize-images.sh`  
3. **Deploy to hosting platform**
4. **Configure domain and SSL**

## Recommended Hosting Platforms

### 1. Netlify (Recommended)
**Best for**: Simple deployment, great performance, free SSL
```bash
# Deploy via Git
1. Push code to GitHub
2. Connect Netlify to repository
3. Auto-deploy on push

# Or drag & drop deployment
1. Zip website files
2. Drag to netlify.com/drop
```

**Custom domain setup**:
- Add domain in Netlify dashboard
- Update DNS records at your registrar
- SSL certificate auto-generates

### 2. Vercel
**Best for**: Modern deployment, edge performance
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# Custom domain
vercel --prod
```

### 3. GitHub Pages
**Best for**: Free hosting, version control integration
```bash
# Setup
1. Create GitHub repository
2. Enable GitHub Pages in settings
3. Select source branch (main)
4. Access via: https://username.github.io/repository-name
```

## Pre-Deployment Checklist

### Content
- [ ] Replace all placeholder images with actual jewelry photos
- [ ] Update contact email if different from contact@alterdworkshop.com
- [ ] Verify Instagram handle is correct
- [ ] Test all contact links

### Technical
- [ ] Run `./optimize-images.sh` to process images
- [ ] Test website locally: `python -m http.server 8000`
- [ ] Verify all images load correctly
- [ ] Test gallery functionality
- [ ] Check mobile responsiveness

### SEO & Performance
- [ ] Update og:url with actual domain
- [ ] Update schema.org URL
- [ ] Verify meta descriptions
- [ ] Test with Google PageSpeed Insights
- [ ] Submit to Google Search Console

## Domain Configuration

### DNS Records (update at your registrar)
```
Type    Name    Value
A       @       [hosting-ip-address]
CNAME   www     [hosting-domain]
```

### SSL Certificate
Most hosting platforms provide free SSL certificates:
- Netlify: Automatic via Let's Encrypt
- Vercel: Automatic SSL
- Cloudflare: Free SSL with CDN

## Performance Optimization

### Enable Compression
Most hosting platforms auto-enable gzip compression. For custom servers:
```nginx
gzip on;
gzip_types text/css application/javascript;
```

### Browser Caching
```nginx
location ~* \.(css|js|png|jpg|webp)$ {
    expires 1y;
    add_header Cache-Control "public, immutable";
}
```

## Monitoring Setup

### Google Analytics (optional)
Add before closing `</head>` tag:
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_TRACKING_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_TRACKING_ID');
</script>
```

### Search Console
1. Visit Google Search Console
2. Add property (domain or URL prefix)
3. Verify ownership
4. Submit sitemap (if generated)

## Post-Deployment Tasks

1. **Test thoroughly**:
   - All pages load correctly
   - Images display properly
   - Gallery navigation works
   - Contact links functional
   - Mobile responsive

2. **Performance testing**:
   - Google PageSpeed Insights
   - GTmetrix analysis
   - Mobile speed test

3. **SEO setup**:
   - Submit to Google Search Console
   - Create Google My Business (if local business)
   - Social media profile links

4. **Backup strategy**:
   - Keep source files backed up
   - Version control with Git
   - Export hosting settings

## Maintenance

### Regular Tasks
- Update jewelry portfolio images
- Check for broken links monthly
- Monitor website performance
- Update contact information as needed
- Backup website files

### Performance Monitoring
- Monthly PageSpeed Insights check
- Review Google Search Console reports
- Monitor social media referrals
- Check email contact form functionality

## Support
- Hosting issues: Contact your hosting provider
- Performance optimization: Run performance-checklist.md
- Image optimization: Re-run ./optimize-images.sh
- Code updates: Edit CSS/JS files as needed
#!/bin/bash

# Image Optimization Script for Alter'D Workshop Website
# This script converts and optimizes images for web performance

echo "🔧 Starting image optimization for Alter'D Workshop website..."

# Check if required tools are installed
check_tool() {
    if ! command -v $1 &> /dev/null; then
        echo "❌ $1 is not installed. Please install it first."
        echo "   For macOS: brew install $1"
        echo "   For Ubuntu: sudo apt-get install $1"
        return 1
    fi
    return 0
}

# Check for required tools
if ! check_tool "cwebp" || ! check_tool "imagemagick"; then
    echo "❌ Required tools missing. Please install webp and imagemagick."
    echo "   macOS: brew install webp imagemagick"
    echo "   Ubuntu: sudo apt-get install webp imagemagick"
    exit 1
fi

# Function to optimize images
optimize_image() {
    local input_file="$1"
    local max_width="$2"
    local quality="$3"
    
    if [ ! -f "$input_file" ]; then
        echo "⚠️  File not found: $input_file"
        return
    fi
    
    # Get filename without extension
    local filename=$(basename "$input_file")
    local name="${filename%.*}"
    local dir=$(dirname "$input_file")
    
    echo "🖼️  Processing: $filename"
    
    # Resize if needed (only if image is larger than max_width)
    local resized_file="${dir}/${name}_resized.jpg"
    convert "$input_file" -resize "${max_width}x${max_width}>" -quality $quality "$resized_file"
    
    # Create WebP version
    local webp_file="${dir}/${name}.webp"
    cwebp -q $quality "$resized_file" -o "$webp_file"
    
    # Replace original with resized version
    mv "$resized_file" "${dir}/${name}.jpg"
    
    echo "✅ Created: ${name}.jpg and ${name}.webp"
}

# Create example images if they don't exist
create_example_images() {
    echo "📸 Creating example placeholder images..."
    
    # Create colored placeholder images for development
    # Logo (400x200)
    convert -size 400x200 xc:#c59d89 -gravity center -pointsize 24 -fill white -annotate +0+0 "ALTER'D\nWORKSHOP" images/logos/alterd-workshop-logo.png
    
    # Hero image (1920x1080)
    convert -size 1920x1080 gradient:#1a1612-#2a221a -gravity center -pointsize 48 -fill #c59d89 -annotate +0+0 "Hero Image\n1920x1080" images/hero/jewelry-hero-main.jpg
    
    # About image (600x800)
    convert -size 600x800 xc:#2a221a -gravity center -pointsize 32 -fill #c59d89 -annotate +0+0 "Pierce Alter\nWorkshop\n600x800" images/about/pierce-alter-workshop.jpg
    
    # Gallery images (800x800)
    convert -size 800x800 xc:#c59d89 -gravity center -pointsize 24 -fill white -annotate +0+0 "Engagement Ring\nRose Gold Diamond" images/gallery/rings/engagement-ring_rose-gold_diamond_01.jpg
    convert -size 800x800 xc:#8b7355 -gravity center -pointsize 24 -fill white -annotate +0+0 "Statement Pendant\nWhite Gold Sapphire" images/gallery/pendants/pendant_white-gold_sapphire_statement.jpg
    convert -size 800x800 xc:#d4af37 -gravity center -pointsize 24 -fill white -annotate +0+0 "Drop Earrings\nRose Gold Pearl" images/gallery/earrings/earrings_rose-gold_pearl_drops.jpg
    convert -size 800x800 xc:#c0c0c0 -gravity center -pointsize 24 -fill black -annotate +0+0 "Statement Ring\nSterling Silver" images/gallery/rings/ring_sterling-silver_diamonds_statement.jpg
    convert -size 800x800 xc:#e5e4e2 -gravity center -pointsize 24 -fill black -annotate +0+0 "Wedding Band\nPlatinum Engraved" images/gallery/wedding-bands/wedding-band_platinum_engraved.jpg
    convert -size 800x800 xc:#ffd700 -gravity center -pointsize 24 -fill black -annotate +0+0 "Custom Pendant\nYellow Gold Emerald" images/gallery/pendants/pendant_yellow-gold_emerald_custom.jpg
    
    echo "✅ Created example placeholder images"
}

# Main optimization process
main() {
    echo "🚀 Starting image optimization process..."
    
    # Create example images for development
    create_example_images
    
    echo "🔄 Converting images to WebP format..."
    
    # Optimize logo
    if [ -f "images/logos/alterd-workshop-logo.png" ]; then
        cwebp -q 90 images/logos/alterd-workshop-logo.png -o images/logos/alterd-workshop-logo.webp
        echo "✅ Logo converted to WebP"
    fi
    
    # Optimize hero image
    optimize_image "images/hero/jewelry-hero-main.jpg" 1920 85
    
    # Optimize about image
    optimize_image "images/about/pierce-alter-workshop.jpg" 600 80
    
    # Optimize gallery images
    for category in rings pendants earrings wedding-bands; do
        for img in images/gallery/${category}/*.jpg; do
            [ -f "$img" ] && optimize_image "$img" 800 85
        done
    done
    
    # Create favicons from logo
    if [ -f "images/logos/alterd-workshop-logo.png" ]; then
        convert images/logos/alterd-workshop-logo.png -resize 32x32 images/logos/favicon-32x32.png
        convert images/logos/alterd-workshop-logo.png -resize 16x16 images/logos/favicon-16x16.png
        echo "✅ Favicons created"
    fi
    
    echo ""
    echo "🎉 Image optimization complete!"
    echo ""
    echo "📊 Summary:"
    echo "   - All images converted to WebP format"
    echo "   - Images resized to optimal dimensions"
    echo "   - Quality optimized for web delivery"
    echo "   - Favicons generated"
    echo ""
    echo "💡 Next steps:"
    echo "   1. Replace placeholder images with actual jewelry photos"
    echo "   2. Test the website in a browser"
    echo "   3. Run performance tests with Google PageSpeed Insights"
}

# Run the script
main
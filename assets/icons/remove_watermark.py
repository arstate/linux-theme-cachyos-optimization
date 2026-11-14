#!/usr/bin/env python3
"""
Script to remove watermark from the bottom right corner of an image.
"""

from PIL import Image, ImageDraw

# Input and output paths
input_path = "/home/arya/icon/Gemini_Generated_Image_r1zt6rr1zt6rr1zt.png"
output_path = "/home/arya/icon/Gemini_Generated_Image_r1zt6rr1zt6rr1zt-no-wm.png"

# Load the image
img = Image.open(input_path)
width, height = img.size
print(f"Image dimensions: {width}x{height}")

# The watermark is a small sparkle in the bottom right corner on black background
# We'll fill a small region in the bottom right with black to remove it
# Estimating watermark position and size based on visual inspection

# Define the watermark region (bottom right corner)
# Adjust these values based on the actual watermark size and position
watermark_width = int(width * 0.08)  # ~8% of image width
watermark_height = int(height * 0.08)  # ~8% of image height

watermark_x = width - watermark_width
watermark_y = height - watermark_height

print(f"Watermark region: ({watermark_x}, {watermark_y}) to ({width}, {height})")

# Create a copy of the image to modify
img_clean = img.copy()

# Get the background color from the bottom right area (should be black)
# Fill the watermark area with black
draw = ImageDraw.Draw(img_clean)
draw.rectangle(
    [watermark_x, watermark_y, width, height],
    fill=(0, 0, 0)  # Black color
)

# Save the result
img_clean.save(output_path, "PNG")
print(f"Watermark removed! Saved to: {output_path}")

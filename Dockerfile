# Use official Nginx image from Docker Hub
FROM nginx:latest

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy your website files to Nginx folder
COPY ./html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

# Use official Nginx image from Docker Hub
FROM nginx:latest

# Remove default nginx static assets (optional)
RUN rm -rf /usr/share/nginx/html/*

# Copy website files into container
COPY html/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

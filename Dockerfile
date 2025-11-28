# Use official Nginx image from Docker Hub
FROM nginx:latest

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

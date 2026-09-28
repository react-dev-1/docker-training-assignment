# Uses node version 22 as the base image
FROM node:22

# Goes to the app directory 
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the app into the container
COPY . .

# Set port environment variable
ENV PORT=9000

# Expose the port so the computer can access it
EXPOSE 9000

# Run the app
CMD ["npm", "start"]
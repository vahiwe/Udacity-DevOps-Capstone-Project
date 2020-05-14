# The first instruction is what image we want to base our container on
# We Use an official Python runtime as a parent image
FROM python:3.6

# The enviroment variable ensures that the python output is set straight
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1

# create root directory for our project in the container
RUN mkdir /TwitterAnalysis

# Copy the current directory contents into the container at /TwitterAnalysis
COPY . /TwitterAnalysis/

# Set the working directory to /TwitterAnalysis/model_setup
WORKDIR /TwitterAnalysis/model_setup

# Install any needed packages specified in setup.py
RUN pip install -e .

# Set the working directory to /TwitterAnalysis/model_setup
WORKDIR /TwitterAnalysis

# Install spacy language model
RUN python -m spacy download en

# Make migrations
RUN python manage.py makemigrations

# Make migrations
RUN python manage.py migrate

# expose the port 8000
EXPOSE 8000

# define the default command to run when starting the container using Django
# Uncomment the next two lines to use django to render app and comment gunicorn command
# ENTRYPOINT ["python", "manage.py"]
# CMD ["runserver", "0.0.0.0:8000"]

# define the default command to run when starting the container using gunicorn
CMD ["gunicorn", "-k", "gevent", "-w", "2", "--bind", ":8000", "-t", "60", "TwitterAnalysis.wsgi:application"]
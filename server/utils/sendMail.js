const nodemailer = require('nodemailer');
const Mailgen = require('mailgen');

const sendEmailForVerification = async (fullName, email, otp) => {
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: process.env.USER_EMAIL,
      pass: process.env.PASSWORD,
    },
  });

  const mailGenerator = new Mailgen({
    theme: 'default',
    product: {
      name: 'Green-Commute',
      link: 'https://www.google.com',
    },
  });

  const emailFormat = {
    body: {
      name: fullName,
      intro:
        "Welcome to Green-Commute! We're very excited to have you on board.",
      action: {
        instructions: 'This is your OTP to sign in',
        button: {
          color: '#22BC66',
          text: otp,
        },
      },
      outro:
        "Need help, or have questions? Just reply to this email, we'd love to help.",
    },
  };

  const emailBody = mailGenerator.generate(emailFormat);
  const emailText = mailGenerator.generatePlaintext(emailFormat);

  const mailOptions = {
    from: 'durgesh.d1805@gmail.com',
    to: email,
    subject: 'Verify your Account',
    html: emailBody,
    text: emailText,
  };
  await transporter.sendMail(mailOptions);
  console.log('Email Sent Successfully');
};

module.exports = { sendEmailForVerification };

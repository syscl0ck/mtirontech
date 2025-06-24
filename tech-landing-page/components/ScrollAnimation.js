'use client';

import { useRef } from 'react';
import { motion, useScroll, useTransform } from 'framer-motion';
import { Server, Cloud, Bot } from 'lucide-react';

// An array of service objects to be mapped over.
const services = [
  {
    icon: <Server className="w-10 h-10 text-indigo-300" />,
    title: 'Backend Development',
    description: 'Robust and scalable server-side solutions using modern frameworks.',
  },
  {
    icon: <Cloud className="w-10 h-10 text-indigo-300" />,
    title: 'Cloud Architecture',
    description: 'Designing and managing resilient cloud infrastructure on AWS, Azure, and GCP.',
  },
  {
    icon: <Bot className="w-10 h-10 text-indigo-300" />,
    title: 'AI Integration',
    description: 'Leveraging machine learning models to build intelligent applications.',
  },
];

// A reusable card component that will be animated.
const ServiceCard = ({ icon, title, description, style }) => (
  <motion.div
    style={style}
    className="bg-gray-800/50 p-8 rounded-xl border border-gray-700 w-full max-w-sm"
  >
    <div className="mb-4 inline-block bg-gray-900 p-4 rounded-full">{icon}</div>
    <h3 className="text-2xl font-bold mb-2">{title}</h3>
    <p className="text-gray-400">{description}</p>
  </motion.div>
);

export default function ScrollAnimation() {
  // A ref to the main container section to track scroll progress within it.
  const targetRef = useRef(null);
  const { scrollYProgress } = useScroll({
    target: targetRef,
    // Start animation when the start of the element hits the end of the viewport,
    // and end when the end of the element hits the start of the viewport.
    offset: ['start end', 'end start'],
  });

  // Map scroll progress (0 to 1) to different animation values for each card.
  // As scrollYProgress goes from 0.1 to 0.3, opacity goes from 0 to 1.
  const opacityCard1 = useTransform(scrollYProgress, [0.1, 0.3], [0, 1]);
  const scaleCard1 = useTransform(scrollYProgress, [0.1, 0.3], [0.8, 1]);

  const opacityCard2 = useTransform(scrollYProgress, [0.3, 0.5], [0, 1]);
  const scaleCard2 = useTransform(scrollYProgress, [0.3, 0.5], [0.8, 1]);

  const opacityCard3 = useTransform(scrollYProgress, [0.5, 0.7], [0, 1]);
  const scaleCard3 = useTransform(scrollYProgress, [0.5, 0.7], [0.8, 1]);
  
  // Animate the intro text as well.
  const opacityText = useTransform(scrollYProgress, [0, 0.2], [0, 1]);
  const yText = useTransform(scrollYProgress, [0, 0.2], [50, 0]);

  return (
    // The container is made taller than the viewport to allow for scrolling.
    <section
      ref={targetRef}
      className="relative h-[250vh] bg-gray-800 text-white"
    >
      {/* The content is sticky, so it stays in view while the container scrolls. */}
      <div className="sticky top-0 h-screen flex flex-col items-center justify-center p-8">
        <motion.div style={{ opacity: opacityText, y: yText }} className="text-center mb-16">
            <h2 className="text-4xl md:text-5xl font-bold mb-4">Our Core Services</h2>
            <p className="text-lg md:text-xl text-gray-300 max-w-2xl">
                We provide cutting-edge solutions to drive your business forward.
            </p>
        </motion.div>

        <div className="flex flex-col md:flex-row gap-8">
          <ServiceCard {...services[0]} style={{ opacity: opacityCard1, scale: scaleCard1 }} />
          <ServiceCard {...services[1]} style={{ opacity: opacityCard2, scale: scaleCard2 }} />
          <ServiceCard {...services[2]} style={{ opacity: opacityCard3, scale: scaleCard3 }} />
        </div>
      </div>
    </section>
  );
}

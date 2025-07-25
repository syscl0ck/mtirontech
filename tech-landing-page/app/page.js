import { Code, Layers, Rocket } from 'lucide-react';
import ScrollAnimation from '../components/ScrollAnimation';

const LogoLarge = () => (
  <svg width="300" height="300" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg" className="animate-fade-in-up flicker-rapid">
    <path d="M50 0L93.3 25V75L50 100L6.7 75V25L50 0Z" fill="#818cf8"/>
    <path d="M50 15L84.64 32.5V67.5L50 85L15.36 67.5V32.5L50 15Z" fill="#3730a3"/>
    <path d="M50 28L76 41.5V58.5L50 72L24 58.5V41.5L50 28Z" fill="white"/>
  </svg>
);

const InfoPane = ({ icon, title, children, bgColor }) => {
  return (
    <div className={`h-screen flex items-center justify-center ${bgColor} text-white px-4`}>
      <div className="text-center p-8 max-w-4xl rounded-2xl bg-black/40 backdrop-blur-lg shadow-2xl">
        <div className="mb-6 inline-block bg-white/10 p-4 rounded-full">
            {icon}
        </div>
        <h2 className="text-4xl md:text-5xl font-bold mb-4">{title}</h2>
        <p className="text-lg md:text-xl text-gray-300">
            {children}
        </p>
      </div>
    </div>
  );
};

export default function HomePage() {
  return (
    <div>
      <section className="h-[calc(100vh-80px)] min-h-[600px] flex flex-col items-center justify-center text-center hero-gradient p-6">
        <LogoLarge />
        <h1
          className="mt-8 text-5xl md:text-7xl font-extrabold text-red-500 flicker-rapid glow"
          style={{ animationDelay: '0.2s' }}
        >
          DEAD BYTE SYSTEMS
        </h1>
        <p
          className="mt-4 text-lg md:text-xl text-gray-400 max-w-2xl animate-fade-in-up"
          style={{ animationDelay: '0.4s' }}
        >
          "we can't do this anymore, we forgot how" - <span className="text-red-400">Anonymous</span>
        </p>
        <p className="mt-2">
          <a href="https://github.com/yourrepo" className="text-indigo-400 hover:underline">
            View on GitHub
          </a>
        </p>
      </section>

      {/* --- Scroll-based Animation Section --- */}
      <ScrollAnimation />
      
      {/* --- Static Placeholder Section --- */}
      <InfoPane
        bgColor="bg-gradient-to-r from-gray-900 via-purple-900 to-black"
        icon={<Rocket size={48} className="text-red-500"/>}
        title="The Machines Awaken"
      >
        Dark corridors hum with the glow of cursed servers. Build your own nightmare with our template and unleash it online.
      </InfoPane>

      <InfoPane
        bgColor="bg-gradient-to-r from-blue-900 via-sky-800 to-gray-900"
        icon={<Layers size={48} className="text-indigo-400"/>}
        title="Neon Networks"
      >
        Dazzling lights guide you through pristine codebases crafted with precision.
      </InfoPane>

    </div>
  );
}

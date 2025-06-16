export default function Footer() {
  return (
    <footer className="bg-gray-900 border-t border-gray-800">
      <div className="container mx-auto px-6 py-8 text-center text-gray-500">
        <p>&copy; {new Date().getFullYear()} TechCo. All Rights Reserved.</p>
        <p className="mt-2 text-sm">Build Great Things</p>
      </div>
    </footer>
  );
}

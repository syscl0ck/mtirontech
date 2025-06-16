import Link from 'next/link';
import { getSortedPostsData } from '../../lib/posts';

export default function BlogIndexPage() {
  const allPostsData = getSortedPostsData();

  return (
    <div className="container mx-auto px-6 py-12 max-w-4xl">
      <h1 className="text-4xl font-bold mb-8 border-b border-gray-700 pb-4">The Blog</h1>
      <section>
        <ul className="space-y-8">
          {allPostsData.map(({ slug, date, title, excerpt }) => (
            <li key={slug} className="bg-gray-800/50 p-6 rounded-lg hover:bg-gray-800 transition-colors duration-300">
              <Link href={`/blog/${slug}`} className="block">
                <h2 className="text-2xl font-bold text-indigo-300 hover:underline">{title}</h2>
                <small className="text-gray-400 mt-1 block">{date}</small>
                <p className="mt-3 text-gray-300">{excerpt}</p>
              </Link>
            </li>
          ))}
        </ul>
      </section>
    </div>
  );
}

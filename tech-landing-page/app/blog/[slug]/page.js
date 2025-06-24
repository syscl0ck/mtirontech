import { getPostData, getAllPostSlugs } from '../../../lib/posts';
import { notFound } from 'next/navigation';

export async function generateStaticParams() {
  const paths = getAllPostSlugs();
  return paths;
}

export async function generateMetadata({ params }) {
  const postData = await getPostData(params.slug).catch(() => null);
  if (!postData) {
    return { title: 'Post Not Found' };
  }
  return {
    title: postData.title,
    description: postData.excerpt,
  };
}

export default async function PostPage({ params }) {
  const postData = await getPostData(params.slug).catch(() => null);

  if (!postData) {
    notFound();
  }

  return (
    <article className="container mx-auto px-6 py-12 max-w-3xl">
      <h1 className="text-4xl font-extrabold mb-2 tracking-tight">{postData.title}</h1>
      <div className="text-gray-400 mb-8">{postData.date}</div>
      <div
        className="prose prose-invert prose-lg max-w-none prose-h2:text-indigo-300 prose-a:text-indigo-400 hover:prose-a:text-indigo-300"
        dangerouslySetInnerHTML={{ __html: postData.contentHtml }}
      />
    </article>
  );
}

class Controller_Staffdaily extends Controller
{
    public function action_index()
    {
        $search = Input::get('q', '');
        $page = (int) Input::get('page', 1);
        $per_page = 10;
        $offset = ($page - 1) * $per_page;

        $query = Model_Staff_Daily_Post::query()
            ->where('public_status', 'published')
            ->where('public_date', '>=', DB::expr('DATE_SUB(CURDATE(), INTERVAL 3 MONTH)'))
            ->where('deleted_at', null);

        if ($search !== '') {
            $query->where('title', 'LIKE', "%{$search}%");
        }

        $total = $query->count();
        $posts = $query
            ->order_by('public_date', 'desc')
            ->rows_offset($offset)
            ->rows_limit($per_page)
            ->get();

        return Response::forge(View::forge('staffdaily/index', [
            'posts' => $posts,
            'total' => $total,
            'page' => $page,
            'per_page' => $per_page,
        ]));
    }

    public function action_create()
    {
        if (Input::method() == 'POST') {
            $post = Model_Staff_Daily_Post::forge(Input::post());

            if ($post and $post->save()) {
                Session::set_flash('success', 'Post created.');
                Response::redirect('staffdaily');
            } else {
                Session::set_flash('error', 'Could not save.');
            }
        }

        return Response::forge(View::forge('staffdaily/create'));
    }

    public function action_edit($id)
    {
        $post = Model_Staff_Daily_Post::find($id);

        if (Input::method() == 'POST') {
            $post->set(Input::post());

            if ($post->save()) {
                Session::set_flash('success', 'Post updated.');
                Response::redirect('staffdaily');
            } else {
                Session::set_flash('error', 'Could not update.');
            }
        }

        return Response::forge(View::forge('staffdaily/edit', ['post' => $post]));
    }

    public function action_delete($id)
    {
        $post = Model_Staff_Daily_Post::find($id);

        if ($post and $post->delete()) {
            Session::set_flash('success', 'Post deleted.');
        } else {
            Session::set_flash('error', 'Could not delete.');
        }

        Response::redirect('staffdaily');
    }
}

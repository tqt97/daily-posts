```php
public function action_edit($id)
{
    if (Input::method() === 'POST') {
        DB::start_transaction();

        try {
            DB::update('staff_daily_posts')
                ->set([
                    'title' => Input::post('title'),
                    'staff_name' => Input::post('staff_name'),
                    'public_date' => Input::post('public_date'),
                    'public_status' => Input::post('public_status'),
                    'updated_at' => date('Y-m-d H:i:s'),
                ])
                ->where('id', $id)
                ->execute();

            // Có thể xoá rồi insert lại schedule/points (tuỳ cách xử lý update của bạn)
            DB::delete('staff_daily_schedules')->where('post_id', $id)->execute();
            foreach (Input::post('schedules', []) as $order => $item) {
                DB::insert('staff_daily_schedules')->set([
                    'post_id' => $id,
                    'sort_order' => $order,
                    'time_hh' => $item['time_hh'],
                    'time_mm' => $item['time_mm'],
                    'job_title' => $item['job_title'],
                    'job_content' => $item['job_content'],
                ])->execute();
            }

            DB::delete('staff_daily_points')->where('post_id', $id)->execute();
            foreach (Input::post('points', []) as $order => $item) {
                DB::insert('staff_daily_points')->set([
                    'post_id' => $id,
                    'sort_order' => $order,
                    'title' => $item['title'],
                    'details' => $item['details'],
                ])->execute();
            }

            DB::commit_transaction();
            Session::set_flash('success', 'Cập nhật thành công');
            return Response::redirect('staffdaily');
        } catch (Exception $e) {
            DB::rollback_transaction();
            Session::set_flash('error', 'Lỗi: ' . $e->getMessage());
        }
    }

    // Load post + schedules + points để đổ vào form
    $post = DB::select('*')->from('staff_daily_posts')->where('id', $id)->execute()->current();
    $schedules = DB::select('*')->from('staff_daily_schedules')->where('post_id', $id)->order_by('sort_order')->execute()->as_array();
    $points = DB::select('*')->from('staff_daily_points')->where('post_id', $id)->order_by('sort_order')->execute()->as_array();

    return Response::forge(View::forge('staffdaily/edit', compact('post', 'schedules', 'points')));
}
```

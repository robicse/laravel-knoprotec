<?php
namespace App\Http\Controllers\API\caregiver;
use App\Caregiver;
use App\CaregiverDepartment;
use App\ClinicDoctor;
use App\Doctor;
use App\User;
use Carbon\Carbon;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Intervention\Image\Facades\Image;

class CaregiverController extends Controller
{
    public $successStatus = 200;
    public $failStatus = 404;


    public function caregiver()
    {
            $caregivers = DB::table('caregivers')
            ->join('users', 'caregivers.user_id', '=', 'users.id')
            ->join('clinics', 'caregivers.clinic_id', '=', 'clinics.id')
            ->join('caregiver_department', 'caregivers.department_id', '=', 'caregiver_department.id')
            ->select('users.id as user_id', 'users.name as user_name', 'users.slug as user_slug', 'users.image', 'users.phone', 'users.country_code', 'caregivers.id as caregiver_id', 'caregivers.gender','caregivers.title', 'caregivers.is_active','caregivers.self_service','clinics.id as clinics_id', 'clinics.name as clinics_name', 'clinics.slug as as clinics_slug', 'clinics.address as clinics_address','caregiver_department.caregiver_department as department_name','caregiver_department.id as department_id')
            ->where('caregivers.is_active', '=', 1)
            ->get();

          // dd($caregivers);

            $caregiverSelfservices = DB::table('caregivers')
            ->join('users', 'caregivers.user_id', '=', 'users.id')
            ->join('caregiver_department', 'caregivers.department_id', '=', 'caregiver_department.id')
            ->select('users.id as user_id', 'users.name as user_name', 'users.slug as user_slug', 'users.image', 'users.phone', 'users.country_code', 'caregivers.id as caregiver_id', 'caregivers.gender','caregivers.title', 'caregivers.is_active','caregiver_department.caregiver_department as department_name','caregiver_department.id as department_id')
            ->where('caregivers.is_active', '=', 1)
            ->where('caregivers.self_service', '=', 1)
            ->get();
            // dd($caregiversSelfservice);

        return response()->json(['caregivers' => $caregivers,'caregiverSelfservices'=>$caregiverSelfservices], $this-> successStatus);

    }
    public function caregiverInfo(Request $request)
    {
            $user=User::where('id',$request->id)->get();
        //dd($user);
        if ($user->count() > 0){
            $rate=\App\CaregiverReview::where('caregiver_user_id','=',$user[0]->id)->get();
            if(!empty($rate)){
                $rating=$rate->count();
                $rated['rate']=$rating;
//                dd($rating);
            }
            else{
                $rated['rate']=NULL;
            }

        // dd($user);
        $caregiver=Caregiver::where('user_id',$user[0]->id)->get();
        // dd($caregiver[0]->personal_statement);
         if ($caregiver[0]->clinic_id==null) {
             return response()->json(['user' => $user,'caregiver'=>$caregiver,'rated'=>$rated], $this-> successStatus);
         }
         else{
            $clinic=\App\Clinics::where('id',$caregiver[0]->clinic_id)->get();
            return response()->json(['user' => $user,'caregiver'=>$caregiver,'clinic'=>$clinic,'rated'=>$rated], $this-> successStatus);
          }
        }
        else{
            return response()->json(['result' => 'Curently Not Active'], $this-> failStatus);
        }
    }

    public function doctor_profile_edit(Request $request,$id)
    {
        $slug = Str::slug($request->full_name,'-');
        $drSlugCheck = User::where('slug', $slug)->first();
        if(!empty($drSlugCheck)) {
            $slug = $slug.'-'.Str::random(6);
        }
        $user = User::find($id);
        $user->name = $request->full_name;
        $user->slug =$slug;
        $user->email = $request->email;
        $user->username = $request->username;
        $user->address = $request->address;
        $user->city_state = $request->city_state;
        $user->lat = $request->lat;
        $user->lng = $request->lng;
        $user->blood_group = $request->blood_group;

        $image = $request->file('pro_img');
        if (isset($image)) {
            //make unique name for image
            $currentDate = Carbon::now()->toDateString();

            //delete old image.....
            if(Storage::disk('public')->exists('uploads/profile/'.$user->image))
            {
                Storage::disk('public')->delete('uploads/profile/'.$user->image);
            }

            $imagename = $currentDate . '-' . uniqid() . '.' . $image->getClientOriginalExtension();
//            resize image for category and upload
            $proImage = Image::make($image)->resize(255, 255)->save($image->getClientOriginalExtension());
            /* insert watermark at bottom-right corner with 10px offset */
            $proImage->insert(public_path('/uploads/profile/logo.png'), 'bottom-right', 8, 8);
            //Storage::disk('public')->put('uploads/profile/' . $imagename, $proImage);
            $proImage->save(public_path('uploads/profile/'.$imagename));
        } else {
            $imagename = $user->image;
        }
        $user->image = $imagename;
        $user->save();

        $slug = Str::slug($request->title,'-');
        $check = Doctor::where('slug',$slug)->first();
        if(!empty($check)) {
            $slug = $slug.'-'.Str::random(6);
        }
        $doctor = Doctor::where('user_id',$user->id)->first();
        $doctor->title = $request->title;
        $doctor->slug = $slug;
        $doctor->is_active = 1;
        $doctor->has_homeService = $request->homeService;
        $doctor->department_id = $request->department_id;
        $doctor->experience = $request->experience;
        $doctor->clinic_cost = $request->clinic_cost;
        $doctor->online_cost = $request->online_cost;
//        $doctor->home_cost = $request->home_cost;
        $doctor->other_speciality = $request->other_speciality ;
        $doctor->bmdc = $request->bmdc;
        $doctor->personal_statement = $request->personal_statement;
        $doctor->education = $request->education;
        $doctor->past_experience = $request->past_experience;
        $doctor->award = $request->award;
        $doctor->language = $request->language;
        $doctor->save();

        $cln=$request->a;
        if (isset($cln)) {

            $row_count = count($request->a);

             //dd($row_count);
            $ClinicDoc = ClinicDoctor::where('doctor_id',$doctor->id)->get();
            if($row_count == $ClinicDoc->count()){
               $ClinicDoc = ClinicDoctor::where('doctor_id',$doctor->id)->delete();
                for ($i = 0; $i < $row_count; $i++) {
                    // dd($row_count);
                    $clinic_id = $request->a[$i];
                    $C_Doc = new ClinicDoctor();
                    $C_Doc->doctor_id = $doctor->id;
                    $C_Doc->clinic_id = $clinic_id;
                    $C_Doc->save();}
            }else{
                //insert
                $ClinicDoc = ClinicDoctor::where('doctor_id',$doctor->id)->delete();
                for ($i = 0; $i < $row_count; $i++) {
                    // dd($row_count);
                    $clinic_id = $request->a[$i];
                    $C_Doc = new ClinicDoctor();
                    $C_Doc->doctor_id = $doctor->id;
                    $C_Doc->clinic_id = $clinic_id;
                    $C_Doc->save();
                }
            }

        }

        return response()->json(['success' => 'updated'], $this-> successStatus);
    }

    public function caregiverRegistration(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required',
            'countyCodePrefix' => 'required',
            'name' => 'required',
            'caregivers_title' => 'required',
            //'caregivers_department' => 'required',
            // 'email' => 'required|email|unique:users',
            'phone' => 'required|min:8|numeric',
            'password' => 'required|min:6',
        ]);
        if ($validator->fails()) {
            return response()->json(['error'=>$validator->errors()], $this-> failStatus);
        }
        $phn1 = (int)$request->phone;
        $check = User::where('phone',$phn1)->first();
        if (!empty($check)){
            return response()->json(['Phone' => 'Phone Number already Exist'], $this-> failStatus);
        }
        if ($request->countyCodePrefix == +880) {
            $phn = (int)$request->phone;
        } else {
            $phn = $request->phone;
        }
        $slug = Str::slug($request->name, '-');
        $clmSlugCheck = User::where('slug', $slug)->first();
        if (!empty($clmSlugCheck)) {
            $slug = $slug . '-' . Str::random(6);
        }

        $user = new User();
        $user->name = Str::ucfirst($request->title).' '.$request->name;
        $user->slug = $slug;
        $user->role_id = 5;
        $user->email = $request->email;
        $user->country_code = $request->countyCodePrefix;
        $user->phone = $phn;
        $user->password = Hash::make($request->password);
        $user->status = 0;
        //create session
        Session::put('phone',$phn);
        Session::put('role_id',5);
        Session::put('password',$request->password);
        $user->save();

        $clslug = Str::slug($request->caregivers_title, '-');
        $clSlugCheck = Caregiver::where('slug', $clslug)->first();
        if (!empty($clSlugCheck)) {
            $clslug = $clslug . '-' . Str::random(6);
        }

        $caregivers = new Caregiver();

        $caregivers->user_id = $user->id;
        $caregivers->title = $request->caregivers_title;
        $caregivers->slug = $clslug;
        $caregivers->department_id = $request->caregiver_department;
        $caregivers->is_active = 1;
        if ($request->title=="mrs") {
            $caregivers->gender = "female";
        }
        else{
            $caregivers->gender = "male";
        }
        $caregivers->save();
        return response()->json(['result' => 'success'], $this-> successStatus);
    }

    public function caregiverDepartment()
    {
        $caregiverDepartment=CaregiverDepartment::all();
        return response()->json(['department' => $caregiverDepartment], $this-> successStatus);
    }
     public function show_all_cg_service(Request $request)
    {
        $service_cg_all=\App\CaregiverServices::where('id','>',$request->last_id)->take(10)->get();
        return response()->json(['cg_service' => $service_cg_all], $this->successStatus);
    }

    public function show_all_caregiver_service_list(Request $request)
    {
            $caregiverSelfservices = DB::table('caregivers')
            ->join('users', 'caregivers.user_id', '=', 'users.id')
            ->join('caregiver_department', 'caregivers.department_id', '=', 'caregiver_department.id')
             ->join('caregiver_service_nurse', 'caregiver_service_nurse.user_id', '=', 'users.id')
            ->join('caregiver_services', 'caregiver_service_nurse.service_id', '=', 'caregiver_services.id')
            ->select('users.id as user_id', 'users.name as user_name', 'users.slug as user_slug', 'users.image', 'users.phone', 'users.country_code', 'caregivers.id as caregiver_id', 'caregivers.gender','caregivers.title', 'caregivers.is_active','caregiver_department.caregiver_department as department_name','caregiver_department.id as department_id')
            ->where('caregivers.is_active', '=', 1)
             ->where('caregiver_services.id', '=', $request->id)
            ->get();

            return response()->json(['cg' => $caregiverSelfservices], $this->successStatus);

    }

    public function caregiverListDepartment(Request $request){
        $caregivers = DB::table('caregivers')
            ->join('users', 'caregivers.user_id', '=', 'users.id')
            ->join('caregiver_department', 'caregivers.department_id', '=', 'caregiver_department.id')
            ->select('users.id as user_id', 'users.name as user_name', 'users.slug as user_slug', 'users.image', 'users.phone', 'users.country_code', 'caregivers.id as caregiver_id', 'caregivers.gender','caregivers.schedule_type','caregivers.title', 'caregivers.is_active','caregiver_department.caregiver_department as department_name','caregiver_department.id as department_id')
            ->where('caregivers.is_active', '=', 1)
            ->where('caregivers.department_id', '=', $request->dpt_id)
            ->where('caregivers.schedule_type', '=', $request->schedule_type)
            ->where('caregivers.id', '>', $request->last_id)
            ->take(10)
            ->get();

            return response()->json(['cg' => $caregivers], $this->successStatus);
    }

    public function caregiver_doc_permission(Request $request)
    {
        $caregiver=\App\User::find($request->cg_user_id);

        $check=\App\CaregiverDocumentRequest::where('user_id',Auth::id())->where('caregiver_id',$caregiver->id)->get();

        if(count($check)==0){
            $req=new \App\CaregiverDocumentRequest();
            $req->caregiver_id=$caregiver->id;
            $req->user_id=Auth::id();
            $req->has_permssion=0;
            $req->save();
            return response()->json(['success' => "success"], $this->successStatus);
        }else{
            return response()->json(['failed' => "already requested"], $this->failStatus);
        }


    }
    public function requested_document(Request $request){
        $caregivers = DB::table('caregiver_document_request')
            ->join('caregiver_document', 'caregiver_document.user_id', '=', 'caregiver_document_request.caregiver_id')
            ->join('users', 'caregiver_document.user_id', '=', 'users.id')
            ->where('caregiver_document_request.has_permssion', '=', 1)
            ->where('caregiver_document_request.user_id', '=', Auth::id())
            ->get();

        return response()->json(['success' => $caregivers], $this->successStatus);

    }

    public function CaregiverBookAppointment(Request $request)
    {
        $cg=Caregiver::where('user_id',$request->cg_user_id)->first();

        $cg_schedules = \App\CaregiverSchedule::where('caregiver_id',$request->cg_user_id)->where('status',1)->get();
        
        $date_now = date("Y-m-d");
        $check_schedule=\App\CaregiverScheduleTimeSlot::where('start_date','>',$date_now)->where('caregiver_id',$request->cg_user_id)->where('schedule_type',$cg->schedule_type)->get();
        //dd($schedules);
        return response()->json(['success' => $cg_schedules,'check_schedule' => $check_schedule], $this->successStatus);
    }
    public function Apointment(Request $request)
    {
        //dd("ss");
        $cg=Caregiver::where('user_id',$request->cg_id)->first();

        if($cg->schedule_type==4){
            $caregiver_schedule=new \App\CaregiverScheduleTimeSlot;
            $caregiver_schedule->user_id=$request->user_id;
            $caregiver_schedule->caregiver_id=$request->cg_id;
            $caregiver_schedule->start_date=$request->start_date;
            $endDate=date('Y-m-d',strtotime('+30 days',strtotime($request->start_date)));
            $caregiver_schedule->end_date=$endDate;
            $caregiver_schedule->time_from="00:00";
            $caregiver_schedule->time_to="23:59";
            $caregiver_schedule->schedule_type=4;
            $caregiver_schedule->save();
            return response()->json(['success' => $caregiver_schedule], $this->successStatus);
        }else{
            $epoch = strtotime("next"." ".$request->date);
            $dt = new \DateTime("@$epoch");
            $next_date = date('Y-m-d', strtotime($dt->format('Y-m-d').' +1 day'));

            $caregiver_schedule=new \App\CaregiverScheduleTimeSlot;
            $caregiver_schedule->user_id=$request->user_id;
            $caregiver_schedule->caregiver_id=$request->cg_id;
            $caregiver_schedule->start_date=$next_date;
            $caregiver_schedule->end_date=$next_date;
            $caregiver_schedule->time_from=$request->start_time;
            $caregiver_schedule->time_to=$request->finish_time;
            $caregiver_schedule->schedule_type=$cg->schedule_type;
            $caregiver_schedule->save();
            return response()->json(['success' => $caregiver_schedule], $this->successStatus);
        }

    }

    public function Review(Request $request)
    {
        $review=new \App\CaregiverReview();
        $review->user_id=Auth::user()->id;
        $review->caregiver_user_id=$request->cg_user_id;
        $review->star=$request->star;
        $review->problem=$request->problem;
        $review->description=$request->description;
        $review->save();
        return response()->json(['success' => $review], $this->successStatus);
    }

    public function show_all_caregiver_by_service(Request $request){

        $caregiver_service= DB::table('caregiver_services')
            ->join('caregiver_service_nurse', 'caregiver_services.id', '=', 'caregiver_service_nurse.service_id')
            ->where('caregiver_service_nurse.user_id', '=', $request->cg_user_id)
            ->get();

        return response()->json(['caregiver_service' => $caregiver_service], $this->successStatus);
    }



}

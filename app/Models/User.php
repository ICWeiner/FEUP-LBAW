<?php

namespace App\Models;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use Notifiable;

    // Don't add create and update timestamps in database.
    public $timestamps  = false;


    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'id_user';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', #'remember_token', #TODO: figure this out
    ];

    /*
     The cards this user owns. TODO: change this to orders, reviews, etc.?

    public function cards()
    {
        return $this->hasMany('App\Models\Card');
    }*/

    public function orders() {
        return $this->hasMany('App\Models\ord');
    }

    public function comments() {
        return $this->hasMany(comment::class);
    }

    public function reviews() {
        return $this->hasMany('App\Models\review');
    }

    public function address() {
        return $this->hasOne(addressBook::class, 'id_address_book');
    }

    public function paymentInfo() {
        return $this->hasOne(paymentInfo::class, 'id_payment_info');
    }

    public function banned() {
        return $this->hasMany('App\Models\banned');
    }
}

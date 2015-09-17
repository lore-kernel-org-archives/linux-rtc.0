Return-Path: <rtc-linux+bncBC7LNKXBRUKBBQHL5KXQKGQECE47GRY@googlegroups.com>
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.132])
        by gmr-mx.google.com with ESMTPS id w5si397262pbt.1.2015.09.17.05.44.48
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 05:44:48 -0700 (PDT)
Message-ID: <55FAB5B6.3010605@rock-chips.com>
Date: Thu, 17 Sep 2015 20:44:38 +0800
From: Xing Zheng <zhengxing@rock-chips.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
 a.zummo@towertech.it, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 9/9] rtc: hym8563: make sure hym8563 can be
 normal work
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com> <1442486368-1912-1-git-send-email-zhengxing@rock-chips.com> <3439697.Ymf0XB1EzX@diego> <20150917123138.GG4287@piout.net>
In-Reply-To: <20150917123138.GG4287@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 2015=E5=B9=B409=E6=9C=8817=E6=97=A5 20:31, Alexandre Belloni wrote:
> Hi,
>
> On 17/09/2015 at 14:07:47 +0200, Heiko St=C3=BCbner wrote :
>> Am Donnerstag, 17. September 2015, 18:39:28 schrieb Xing Zheng:
>>> The rtc hym8563 maybe failed to register if first startup or rtc
>>> powerdown:
>>> [    0.988540 ] rtc-hym8563 1-0051: no valid clock/calendar values avai=
lable
>>> [    0.995642 ] rtc-hym8563 1-0051: rtc core: registered hym8563 as rtc=
0 [
>>>    1.078985 ] rtc-hym8563 1-0051: no valid clock/calendar values availa=
ble [
>>>     1.085698 ] rtc-hym8563 1-0051: hctosys: unable to read the hardware
>>> clock
>>>
>>> We can set initial time for rtc and register it:
>>> [    0.995678 ] rtc-hym8563 1-0051: rtc core: registered hym8563 as rtc=
0
>>> [    1.080313 ] rtc-hym8563 1-0051: setting system clock to 2000-01-01
>>> 00:02:00 UTC (946684920)
>> hmm, not setting a false date was actually intentional when I did the dr=
iver.
>>
>> In my mind it is better to shout and keep programs from using wrong valu=
es
>> than to set some arbitary date and let programs silently use this wrong =
value.
>>
> Indeed, I find it worse to set a wrong value instead of returning an
> error. Userspace has to define its policy when reading the time fails.
>
OK, I got it, this patch will be abandoned at next version.
Thanks.

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

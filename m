Return-Path: <rtc-linux+bncBDS7HNEFSALRBV5EVOXQKGQEHQDWKLQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c7si9874wiy.3.2015.09.05.04.30.30
        for <rtc-linux@googlegroups.com>;
        Sat, 05 Sep 2015 04:30:30 -0700 (PDT)
Date: Sat, 5 Sep 2015 13:30:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mitja Spes <mitja@lxnav.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Philippe De Muyter <phdm@macqel.be>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Abracon ABX8XX write RTC fix
Message-ID: <20150905113027.GK29358@piout.net>
References: <eb60f012f707d580f3c57f2f16e4c7aba9a4cc23.1441179975.git.mitja@lxnav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <eb60f012f707d580f3c57f2f16e4c7aba9a4cc23.1441179975.git.mitja@lxnav.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/09/2015 at 10:02:29 +0200, Mitja Spes wrote :
> Fixed RTC write bit as per application manual
> 
> Signed-off-by: Mitja Spes <mitja@lxnav.com>
> ---
>  drivers/rtc/rtc-abx80x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

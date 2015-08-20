Return-Path: <rtc-linux+bncBDS7HNEFSALRBBGN3GXAKGQE6U7TIGQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x20si21210wia.0.2015.08.20.16.45.07
        for <rtc-linux@googlegroups.com>;
        Thu, 20 Aug 2015 16:45:07 -0700 (PDT)
Date: Fri, 21 Aug 2015 01:45:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Felix Janda <felix.janda@posteo.de>, Bibek Basu <bbasu@nvidia.com>
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] drivers/rtc/rtc-as3722: correct month value
Message-ID: <20150820234505.GG3769@piout.net>
References: <20150814084515.GH22269@piout.net>
 <20150814184402.GA8953@nyan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150814184402.GA8953@nyan>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 14/08/2015 at 20:44:02 +0200, Bibek Basu wrote :
> The RTCmonth value is 1-indexed, but the kernel assumes it is 0-indexed.
> This may result in the RTC not rolling over correctly.
> 
> Signed-off-by: Bibek Basu <bbasu@nvidia.com>
> Signed-off-by: Felix Janda <felix.janda@posteo.de>
> ---
> v1 -> v2: Correct attribution and use original commit message
> ---
>  drivers/rtc/rtc-as3722.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks. However, it was not necessary to spoof the From: in
your email, It is enough to have a From: line in the body of the mail.

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

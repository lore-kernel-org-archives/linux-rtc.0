Return-Path: <rtc-linux+bncBDS7HNEFSALRBE7EVCVQKGQEKZJZCQI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ha2si19842wib.1.2015.05.30.14.56.34
        for <rtc-linux@googlegroups.com>;
        Sat, 30 May 2015 14:56:34 -0700 (PDT)
Date: Sat, 30 May 2015 23:56:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jan Kardell <jan.kardell@telliq.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Vincent Donnefort <vdonnefort@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>, oen@telliq.com
Subject: [rtc-linux] Re: [PATCH v3] rtc: pcf8563 fix: return -EINVAL if we
 read an invalid time.
Message-ID: <20150530215634.GL2185@piout.net>
References: <1432795725-8350-1-git-send-email-jan.kardell@telliq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432795725-8350-1-git-send-email-jan.kardell@telliq.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 28/05/2015 at 08:48:45 +0200, Jan Kardell wrote :
> Return -EINVAL if the voltage low bit is set to avoid getting a bogus
> time at boot.
> There was a comment stating that util-linux hwclock refuses to set a
> new time if we return an error code on read, but at least the current
> version do set the time as expected. Remove the comment and the check
> for valid time, and let the rtc core check it for us.
> 
> Changes in v2: Remove the test for invalid time. Change dev_err to
> dev_info when voltage low is set.
> 
> Changes in v3: Use dev_err when voltage low is set.
> 
> Signed-off-by: Jan Kardell <jan.kardell@telliq.com>
> ---
>  drivers/rtc/rtc-pcf8563.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

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

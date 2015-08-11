Return-Path: <rtc-linux+bncBDS7HNEFSALRBO5VVCXAKGQEOF4RJ3A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si97754wib.2.2015.08.11.08.54.35
        for <rtc-linux@googlegroups.com>;
        Tue, 11 Aug 2015 08:54:35 -0700 (PDT)
Date: Tue, 11 Aug 2015 17:54:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: akpm@linux-foundation.org, linaro-kernel@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	"moderated list:BLACKFIN RTC DRIVER" <adi-buildroot-devel@lists.sourceforge.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH 9/15 V2] drivers: rtc: Drop (un)likely before IS_ERR(_OR_NULL)
Message-ID: <20150811155434.GT3411@piout.net>
References: <cdfa3fb76901fe1c4a5756e7e64cb3370cf6317a.1438331416.git.viresh.kumar@linaro.org>
 <b8be698a8625ceb9adc8da51cd9474626db7c3d1.1438339891.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <b8be698a8625ceb9adc8da51cd9474626db7c3d1.1438339891.git.viresh.kumar@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 31/07/2015 at 16:23:43 +0530, Viresh Kumar wrote :
> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> is no need to do that again from its callers. Drop it.
> 
> gemini driver was using likely() for a failure case while the rtc driver
> is getting registered. That looks wrong and it should really be
> unlikely. But because we are killing all the unlikely() flags, lets kill
> that too.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Removed the likely() part from gemini driver and the changelog wasn't
>   updated to match that. Fixed the changelog now.
> 
>  drivers/rtc/interface.c  | 2 +-
>  drivers/rtc/rtc-bfin.c   | 2 +-
>  drivers/rtc/rtc-gemini.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
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

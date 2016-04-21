Return-Path: <rtc-linux+bncBDS7HNEFSALRBTGA4W4AKGQECKZVIKQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t18si9989wmt.0.2016.04.21.16.20.43
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 16:20:43 -0700 (PDT)
Date: Fri, 22 Apr 2016 01:20:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, soren.brinkmann@xilinx.com,
	Michal Simek <michal.simek@xilinx.com>, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
	Anirudha Sarangi <anirudh@xilinx.com>,
	Srikanth Vemula <svemula@xilinx.com>,
	Srinivas Goud <sgoud@xilinx.com>,
	Anurag Kumar Vulisha <anuragku@xilinx.com>
Subject: [rtc-linux] Re: [PATCH V4] rtc: zynqmp: Update seconds time
 programming logic
Message-ID: <20160421232042.GD29844@piout.net>
References: <1461167255-33945-1-git-send-email-anuragku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461167255-33945-1-git-send-email-anuragku@xilinx.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/04/2016 at 21:17:35 +0530, Anurag Kumar Vulisha wrote :
> We programe RTC time using SET_TIME_WRITE register and read the RTC
> current time using CURRENT_TIME register. When we set the time by
> writing into SET_TIME_WRITE Register and immediately try to read the
> rtc time from CURRENT_TIME register, the previous old value is
> returned instead of the new loaded time. This is because RTC takes
> nearly 1 sec to update the  new loaded value into the CURRENT_TIME
> register. This behaviour is expected in our RTC IP.
> 
> This patch updates the driver to read the current time from SET_TIME_WRITE
> register instead of CURRENT_TIME when rtc time is requested within an 1sec
> period after setting the RTC time. Doing so will ensure the correct time
> is given to the user.
> 
> Since there is an delay of 1sec in updating the CURRENT_TIME we are loading
> set time +1sec while programming the SET_TIME_WRITE register, doing this
> will give correct time without any delay when read from CURRENT_TIME.
> 
> This patch updates the above said.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> ---
>  Changes in v4:
>    1. Corrected the read time logic
>  Changes in v2:
>    1. Updated the Time programming logic as suggested by Alexandre Belloni
>    2. Changed the commit message
> ---
>  drivers/rtc/rtc-zynqmp.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
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

Return-Path: <rtc-linux+bncBDS7HNEFSALRBRHG3K4AKGQENNHDNYI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id d92si247943wma.2.2016.04.19.15.37.56
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Apr 2016 15:37:56 -0700 (PDT)
Date: Wed, 20 Apr 2016 00:37:55 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, soren.brinkmann@xilinx.com,
	Michal Simek <michal.simek@xilinx.com>, rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
	Anirudha Sarangi <anirudh@xilinx.com>,
	Srikanth Vemula <svemula@xilinx.com>,
	Anurag Kumar Vulisha <anuragku@xilinx.com>
Subject: [rtc-linux] Re: [PATCH 1/3] RTC: Enable RTC switching to battery
 power when VCC_PSAUX is N/A
Message-ID: <20160419223755.GG29844@piout.net>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 12/04/2016 at 17:45:44 +0530, Anurag Kumar Vulisha wrote :
> In order to conserve battery energy, during the PS operation,
> it is expected that the supply for the battery-powered domain
> to be switched from the battery (VCC_PSBATT) to (VCC_PSAUX) and
> automatically be switched back to battery when VCC_PSAUX voltage
> drops below a limit, doing so prevents the logic within
> the battery-powered domain from functioning incorrectly.
> 
> This patch enables that feature.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> ---
>  drivers/rtc/rtc-zynqmp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
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

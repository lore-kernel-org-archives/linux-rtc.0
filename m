Date: Sat, 30 May 2015 22:53:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefan Agner <stefan@agner.ch>
Cc: a.zummo@towertech.it, maitysanchayan@gmail.com, shawn.guo@linaro.org,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] rtc: snvs: fix wakealarm by call
 enable_irq_wake earlier
Message-ID: <20150530205303.GJ2185@piout.net>
References: <1432222175-30673-1-git-send-email-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432222175-30673-1-git-send-email-stefan@agner.ch>
List-ID: <rtc-linux.googlegroups.com>

Hi,

On 21/05/2015 at 17:29:35 +0200, Stefan Agner wrote :
> When entering suspend while an wakeup alarm is set, enable_set_wake
> should make sure that the RTC interrupt keep being enabled and the
> .irq_set_wake for the RTC interrupt get called. However, since the
> driver uses the suspend_noirq callback, the call to enable_irq_wake
> has been made after disabling the interrupts. While .irq_set_wake
> has been called properly, the interrupt remained disabled.
> 
> Use the suspend callback to call enable_irq_wake early enough to
> ensure the RTC interrupt remains enabled.
> 
> Fixes: 7654e9d4fd8f ("drivers/rtc/rtc-snvs: fix suspend/resume")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I'm applying it after adding
Cc:  <stable@vger.kernel.org> # 3.19

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

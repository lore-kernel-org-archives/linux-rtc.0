Date: Wed, 15 Jul 2015 01:03:12 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Chao Xie <chao.xie@marvell.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [rtc-linux] [RESEND PATCH-v2] rtc: 88pm80x: add device tree
 support
Message-ID: <20150714230312.GI20482@piout.net>
References: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org>
List-ID: <rtc-linux.googlegroups.com>

On 09/07/2015 at 12:25:51 +0530, Vaibhav Hiremath wrote :
> Along with DT support, this patch also cleans up the unnecessary
> code around 'rtc_wakeup' initialization.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/rtc/rtc-88pm80x.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
Applied, thanks.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

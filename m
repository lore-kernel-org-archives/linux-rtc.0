Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBD4N4TBQKGQEOHONSBI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si171321wmd.3.2017.01.13.08.55.42
        for <rtc-linux@googlegroups.com>;
        Fri, 13 Jan 2017 08:55:42 -0800 (PST)
Date: Fri, 13 Jan 2017 17:55:32 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Martin Michlmayr <tbm@cyrius.com>, rtc-linux@googlegroups.com,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: tegra: Sort includes alphabetically
Message-ID: <20170113165532.ynepqstlgnkaylfn@piout.net>
References: <20170112160743.23367-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170112160743.23367-1-thierry.reding@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 12/01/2017 at 17:07:42 +0100, Thierry Reding wrote :
> From: Thierry Reding <treding@nvidia.com>
> 
> The ordering of includes is currently completely arbitrary, making it
> impossible to decide where to put new includes. Remove the dilemma by
> sort the include list alphabetically.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/rtc/rtc-tegra.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
Applied both, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

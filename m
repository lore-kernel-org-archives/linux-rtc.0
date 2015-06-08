Date: Mon, 8 Jun 2015 21:04:39 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: a.zummo@towertech.it, akpm@linux-foundation.org,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] rtc: palmas: Initialise bb_charging flag
 before using it
Message-ID: <20150608190439.GE5222@piout.net>
References: <1432901645-17478-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1432901645-17478-1-git-send-email-ldewangan@nvidia.com>
List-ID: <rtc-linux.googlegroups.com>

On 29/05/2015 at 17:44:05 +0530, Laxman Dewangan wrote :
> Initialise the variable high_bb_charging before using it to avoid
> configuring wrong value and fix following compilation warning:
> 
> /*
> rtc-palmas.c: In function ‘palmas_rtc_probe’:
> rtc-palmas.c:242:7: warning: ‘high_bb_charging’ may be used
> uninitialized in this function
> */
> 

I didn't find a way to get that warning and I'm interested to know how
you got it.

I've applied the patch anyway.

> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

Date: Mon, 11 May 2015 09:26:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: rtc: mc13xxx: fix obfuscated and wrong format string
Message-ID: <20150511072615.GK3338@piout.net>
References: <1424440050-32000-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424440050-32000-1-git-send-email-linux@rasmusvillemoes.dk>
List-ID: <rtc-linux.googlegroups.com>

On 20/02/2015 at 14:47:30 +0100, Rasmus Villemoes wrote :
> According to C99, %2.s means 'print two spaces' (a precision of
> . without following digits or * means 0). The kernel's printf
> implementation, however, treats that case as if no precision was
> given, but relying on that quirk is rather silly. Also, since no -
> (aka left-justify) flag is given, the field with of 2 would then cause
> the alarm->enabled case to come out as "o n". Deobfuscate it.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/rtc/rtc-mc13xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Rebased and applied on rtc-next, thanks.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

Date: Thu, 22 Mar 2018 16:21:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Loic Pallardy <loic.pallardy@st.com>
Subject: Re: [PATCH] rtc: ab8500: Drop AB8540 support
Message-ID: <20180322152126.GU3417@piout.net>
References: <20180322101830.9851-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180322101830.9851-1-linus.walleij@linaro.org>
List-ID: <rtc-linux.googlegroups.com>

On 22/03/2018 at 11:18:30 +0100, Linus Walleij wrote:
> The AB8540 was an evolved version of the AB8500, but it was never
> mass produced or put into products, only reference designs exist.
> The upstream support was never completed and it is unlikely that
> this will happen so drop the support for now to simplify
> maintenance of the AB8500.
> 
> Cc: Loic Pallardy <loic.pallardy@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

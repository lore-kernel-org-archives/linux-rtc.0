Date: Mon, 21 Mar 2016 22:57:45 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Emil Bartczak <emilbart@gmail.com>
Cc: a.zummo@towertech.it, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	robh+dt@kernel.org
Subject: Re: [rtc-linux] [PATCH] drivers/rtc/rtc-mcp795.c: add devicetree
 support
Message-ID: <20160321215745.GF2540@piout.net>
References: <20160321000610.GA21979@emba-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160321000610.GA21979@emba-laptop>
List-ID: <rtc-linux.googlegroups.com>

On 21/03/2016 at 01:06:10 +0100, Emil Bartczak wrote :
> Add device tree support to the rtc-mcp795 driver.
> 
> Signed-off-by: Emil Bartczak <emilbart@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/maxim,mcp795.txt | 11 +++++++++++
>  drivers/rtc/rtc-mcp795.c                               | 10 ++++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

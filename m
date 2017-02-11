Date: Sun, 12 Feb 2017 00:21:35 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc: pcf2127: bulk read only date and time
 registers.
Message-ID: <20170211232135.7bxr4t3pyhdmidh5@piout.net>
References: <20170201124525.36578-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201124525.36578-1-sean.nyekjaer@prevas.dk>
List-ID: <rtc-linux.googlegroups.com>

Hi,

On 01/02/2017 at 13:45:25 +0100, Sean Nyekjaer wrote:
> Read control registers one by one and bulk read time registers.
> This fixes when the clock is read, the watchdog counter register is zeroed.
> 
> The problem is latent without the watchdog patch
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
> Only tested on pcf2127.
> I think the pcf2127 have an issue when the register auto-incr is used,
> when bulk reading the time the watchdog counter is zeroed and stopped.
> 
>  drivers/rtc/rtc-pcf2127.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 8abc4eb8f289..f54a42b419b5 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -403,9 +403,21 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
>  	unsigned char buf[10];
>  	int ret;
> +	int i;
> +
> +	for (i = 0; i < 3; i++) {
> +		ret =
> +		    regmap_read(pcf2127->regmap, PCF2127_REG_CTRL1 + i,
> +				(unsigned int *)(buf + i));
> +		if (ret) {
> +			dev_err(dev, "%s: read error\n", __func__);
> +			return ret;
> +		}
> +	}


CTRL1 and CTRL2 are not used so it is probably enough to only read CTRL3

>  
> -	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1, buf,
> -				sizeof(buf));
> +	ret =
> +	    regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1 + 3, (buf + 3),
> +			     7);

This is weirdly indented/wrapped. Also, you can probably make buf a
char[7] and continue using sizeof() or even better, ARRAY_SIZE()

>  	if (ret) {
>  		dev_err(dev, "%s: read error\n", __func__);
>  		return ret;

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195500;
	b=Z0fo1H8+Pm++iqI/cqEoih1pLaOy2Z4AuenzIs5vy0J9YIrJedRgpq/YJmlriTfvA0Js
	 HaiiQ8ZQp3UI0AYd4cuIw/FppEx6u+tcSGjV+mmZQGv64uGsfL1PfzYvUvgMbKREB6X5G
	 Iu6P4DaChmkJuVitjdQslTpQMm0/eMNR28XMuMeaFMr+vZeA2evFKNSxIApZ9y+ZW2rW1
	 Owqe96szz4VbuFPKokRmeT7QaHioIecfcMhH2waO2soy1vjmWe9bAIgmdktAAeVcwMnS/
	 /pGPwJi4obLOhESwuH0NDaQ0/Qrc6Phlq1dwIjqhPZlAHkNhrd496WsDccwbXuyqv5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195500;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=r9ZKzXuZtQWjeq42Wbv24eyX0v+3OyYtV/ft7hHMkhQ=;
	b=PU+Y5MJrTzjkMBbNvnPM3RPjVNUsClNup68mYUZpLtTTKtEY+HBNAjHjgdl/uAd3zFm2
	 o3QtG1oQ8qilJM90pSXy4IwwQqKIVCXdzOhbkftDZFGj2NBvYJplHpYRfSF5VAGE4Bls6
	 fWdtW5tgzJuIR6D8f3YBy5zCCYS8MMd80TNVm2d6Lk20iv9ZFFUgfZ4dzvJtWVip7HWEy
	 K+n2qV6td2+U+7QosH54pN5JOZQIUXiKuVI194GWewb2km8qFSnIrEM9khLRF1XnMfnnf
	 WQ8smUJh1d0QTabduyEge6OXSrnR01ZVRsnXiVzO/RWlclJyPVnaD4Rj2y5/N36ov+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freeshell.de;
	spf=pass smtp.mailfrom=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=GMalY5k0;
	arc=none smtp.remote-ip=116.202.128.144
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0888606D804;
	Mon,  9 Nov 2026 03:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0888606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=GMalY5k0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1794195460;
	bh=r9ZKzXuZtQWjeq42Wbv24eyX0v+3OyYtV/ft7hHMkhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GMalY5k0UDK0UJgj4WPBefvGt7gSR1qoGF3Bcu57NvUhYCAnjfq7rF7JFZ5uBBZpT
	 Xoie046+rfwvm5AqLWRz5Iw0j/A6NPzVdLJxJI2Y2kuc6dRXGu4neDmZabJ+w4Sx6L
	 jJu6+RLtvbgieuWeR7fqVxQ63I9EswAqRbrWki0f/7rZfDlWZ4x6xJ3ERgeqAwD4+x
	 lVChlnpQvjkU+mYttBRzEz6Kh/2aMcx2U8kY3gtra/jzFYudTCqT7Kz7mFztnSNWXx
	 A8SQAkMUJ17/83EWtbzkQqD1st/4rF9XD24fev2qy1idrMQ1WlcRqEt8zzkFAAezsF
	 9kdYMLC1Fk08Q==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 88606B221A6B;
	Mon,  9 Nov 2026 04:37:36 +0100 (CET)
Message-ID: <d9f4a750-5f9d-4749-929e-330c8776971e@freeshell.de>
Date: Sun, 8 Nov 2026 19:37:34 -0800
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: jh7110: Add the RTC node
To: Owen O'Hehir <oo.hehir@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Hal Feng <hal.feng@starfivetech.com>, "ziv.xu" <ziv.xu@starfivetech.com>,
 Conor Dooley <conor@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20261108212826.15890-1-oo.hehir@gmail.com>
 <20261108212826.15890-5-oo.hehir@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261108212826.15890-5-oo.hehir@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Owen,

On 11/8/26 13:28, Owen O'Hehir wrote:
> Tested on a VisionFive 2 v1.3B.
> 
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 82ea63f71..14f92b942 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -1206,6 +1206,20 @@ pwrc: power-controller@17030000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		rtc: rtc@17040000 {
> +			compatible = "starfive,jh7110-rtc";
> +			reg = <0x0 0x17040000 0x0 0x10000>;
> +			interrupts = <10>, <11>, <12>;
> +			interrupt-names = "ms-pulse", "sec-pulse", "rtc";
> +			clocks = <&aoncrg JH7110_AONCLK_RTC_APB>,
> +				 <&aoncrg JH7110_AONCLK_RTC_CAL>,
> +				 <&aoncrg JH7110_AONCLK_RTC_32K>;
> +			clock-names = "apb", "cal", "32k";
> +			resets = <&aoncrg JH7110_AONRST_RTC_32K>,
> +				 <&aoncrg JH7110_AONRST_RTC_APB>,
> +				 <&aoncrg JH7110_AONRST_RTC_CAL>;
> +		};
> +
>  		csi2rx: csi@19800000 {
>  			compatible = "starfive,jh7110-csi2rx", "cdns,csi2rx";
>  			reg = <0x0 0x19800000 0x0 0x10000>;

Is status property applicable to SoC rtc? If not, then is 'rtc' label
appropriate when there's no status applicable?

Note that Mars CM / CM-Lite System-on-Modules may be used commonly with
board carriers which implement a battery-backed RTC on the I2C bus, and
so another 'rtc' label may be applicable, something to consider. The
initial Mars CM / CM-Lite dts ignores this because there is an
inconvenient I2C bus device address conflict of the SoM EEPROM and some
carrier boards' RTC, and the SoC RTC driver was not then present;
problems for a future self.

-E

Return-Path: <rtc-linux+bncBDJIP47K7MERBQ453DGAKGQEQTSWENA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com. [209.85.218.67])
        by gmr-mx.google.com with ESMTPS id e134si261824itc.5.2017.08.17.14.46.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 14:46:43 -0700 (PDT)
Received: by mail-oi0-f67.google.com with SMTP id q70so7676163oic.2
        for <rtc-linux@googlegroups.com>; Thu, 17 Aug 2017 14:46:43 -0700 (PDT)
Date: Thu, 17 Aug 2017 16:46:41 -0500
From: Rob Herring <robh@kernel.org>
To: Joseph Chen <chenjh@rock-chips.com>
Cc: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, broonie@kernel.org,
	zhangqing@rock-chips.com, lgirdwood@gmail.com,
	linux-rockchip@lists.infradead.org, wdc@rock-chips.com,
	tony.xie@rock-chips.com, linux-input@vger.kernel.org,
	mark.rutland@arm.com, w.egorov@phytec.de, linux-clk@vger.kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RESEND v9 12/12] pinctrl: dt-bindings: add bindings
 for Rockchip RK805 PMIC
Message-ID: <20170817214641.wjwh3zlvdpjt7eaj@rob-hp-laptop>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
 <1502848945-8574-1-git-send-email-chenjh@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1502848945-8574-1-git-send-email-chenjh@rock-chips.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Aug 16, 2017 at 10:02:25AM +0800, Joseph Chen wrote:
> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-rk805.txt  | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt

Acked-by: Rob Herring <robh@kernel.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

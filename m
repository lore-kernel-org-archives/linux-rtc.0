Return-Path: <rtc-linux+bncBDKZNNNLXAHBBO5KY6YQKGQE2KW2OZI@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id vy6si55903pbc.1.2015.10.29.01.13.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 29 Oct 2015 01:13:47 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NWZ002XV2UV9Z30@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 29 Oct 2015 08:13:43 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v4 3/4] regulator: s2mps11: add support for
 S2MPS15 regulators
To: Lee Jones <lee.jones@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
References: <1446094723-6212-1-git-send-email-alim.akhtar@samsung.com>
 <1446094723-6212-4-git-send-email-alim.akhtar@samsung.com>
 <20151029080835.GM4058@x1>
Cc: broonie@kernel.org, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 Thomas Abraham <thomas.ab@samsung.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <5631D533.6070807@samsung.com>
Date: Thu, 29 Oct 2015 17:13:39 +0900
MIME-version: 1.0
In-reply-to: <20151029080835.GM4058@x1>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 29.10.2015 17:08, Lee Jones wrote:
> On Thu, 29 Oct 2015, Alim Akhtar wrote:
> 
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> The S2MPS15 PMIC is similar in functionality to S2MPS11/14 PMIC. It contains
>> 27 LDO and 10 Buck regulators and allows programming these regulators via a
>> I2C interface. This patch adds initial support for LDO/Buck regulators of
>> S2MPS15 PMIC.
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  drivers/regulator/Kconfig   |    4 +-
>>  drivers/regulator/s2mps11.c |  135 ++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 136 insertions(+), 3 deletions(-)
> 
> [...]
> 
>> @@ -1070,6 +1202,7 @@ static const struct platform_device_id s2mps11_pmic_id[] = {
>>  	{ "s2mps11-pmic", S2MPS11X},
>>  	{ "s2mps13-pmic", S2MPS13X},
>>  	{ "s2mps14-pmic", S2MPS14X},
>> +	{ "s2mps15-regulator", S2MPS15X},
>>  	{ "s2mpu02-pmic", S2MPU02},
>>  	{ },
>>  };
> 
> Are you going to s/pmic/regulator/ for the existing devices too?

Yeah, I expected that as well... but of course it is orthogonal to this
patchset.

Best regards,
Krzysztof

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

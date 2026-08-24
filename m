Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B92A43BDDA;
	Mon, 24 Aug 2026 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587391; cv=none; b=MD1lHiaw6jc/Yj9myo5Ck+zvkEfkFD1qi498+cWbQVdbVQn9NtnCe3LF9BUm17dF+Bn1+wFCK9pdXTpEgfXFoxTa5iv7Dpa63zJJYWRTWyW2J6aBx1blccTxRBEA4kQnAq/MD0RG6WFVdsgSPH6vQezqtOTl0nEKkeR5nXNtw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587391; c=relaxed/simple;
	bh=AG6+ddTypEUlHRreNr0P6PVfHH0YA5sAtB1O6uw5j5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCHjvV3j3A80fOfdeWtNACL64ZbkGq4m4Hv9GhrU8PrmB+P1AiREK6aDkabpUhbtWQgsf4fmyOOjwLq4NvWorSdqFQZKyhkGKkN6BX/TFIl5y8a7pCH32TcoHWiVlmeCJV5QWfTyQu1hy+6kGW5I8dinriv6RoUEDJOlCPSwVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h20F1q+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h20F1q+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFB91F000E9;
	Mon, 24 Aug 2026 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787587388;
	bh=RCjgHPB1JH7XWcCeQw9/7Cj3OkRUTR5GrMqvgGXxgB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h20F1q+sQ9eDnw6kKYtK6k4bqjqlzqASvCd2XfkYNgvzsQ8ZsxQ7QSNb+y01IhNaL
	 k/6AFU82DE2dIWQD+fneAQQfYrcqUQbQh9vO3gAxttOc82/kTuHoQ15QsbEwycNcrv
	 vf18dm4vGI+Cf6eRXvUK0HESW8UcYn4BplmUEhsfUMP3uJK5rcxl8wn1hvc7CDC4Td
	 wWqbaxKb7aFiqZqCKln5vwRC7hFHBpM8g1Vyf/9LWK1v42aX6ORTtsErecmUB8AXVF
	 LASbQYjPWcoOf8Hh6tEPGVHYAQzRIHhxlT1Z/fEiVGkEhJnIYGHlA1eksy1IkIHBU0
	 U67IBVt+nSbYA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wyX8b-00000001q4R-47X6;
	Mon, 24 Aug 2026 18:03:05 +0200
Date: Mon, 24 Aug 2026 18:03:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Ociepka <greg@ferrisoft.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] rtc: pm8xxx: do not fail probe when UEFI offset variable
 is missing
Message-ID: <aoxrOaY7RIFEqVr2@hovoldconsulting.com>
References: <20260821181148.1642208-1-greg@ferrisoft.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821181148.1642208-1-greg@ferrisoft.com>

[ +CC: Konrad and Bjorn ]

On Fri, Aug 21, 2026 at 06:11:48PM +0200, Greg Ociepka wrote:
> On machines using "qcom,uefi-rtc-info" the Unix epoch offset for the
> read-only PMIC RTC counter lives in the RTCInfo UEFI variable. The
> driver reads it at probe time and treats every failure as fatal,
> including EFI_NOT_FOUND.

This is intentional as "qcom,uefi-rtc-info" should not be set unless the
offset *is* stored (by the firmware) in said UEFI variable as documented
in the binding.

> That turns a merely-uninitialized clock into a permanently absent one
> on firmware that never creates the variable. The ASUS Zenbook A16
> (UX3607OA, Snapdragon X2 Elite Extreme "Glymur", InsydeH2O UEFI) is
> such a machine: qseecom and uefisecapp come up fine, other variables
> in the same Qualcomm vendor GUID (882f8c2b-9646-435f-8de5-f208ff80c1bd)
> exist and are readable, but among the 110 variables exposed through
> efivarfs there is no RTCInfo -- and Windows on the same machine does
> not create one either. Probe then fails:

Then the devicetree added by e8fbbca94db7 ("arm64: dts: qcom: glymur:
Add Asus Zenbook A16 (UX3607OA)") for 7.3 is incorrect and you should
drop the corresponding DT property.

>   rtc-pm8xxx c426000.spmi:pmic@0:rtc@6100: probe with driver rtc-pm8xxx
>       failed with error -2
> 
> This is a chicken-and-egg failure: pm8xxx_rtc_write_uefi_offset()
> would create the variable (the set path uses EFI_VARIABLE_NON_VOLATILE
> attributes and efivar_set_variable() creates missing variables), but
> it can only run from the RTC set_time path -- and the RTC device never
> registers because probe failed. The variable can never come into
> existence.

No, it's not. If your firmware doesn't use the EFI variable for the
offset then you need to figure out how the RTC is supposed to work on
these platforms (e.g. if you can set the time using some other measure
and should not be using an external offset all).

> Treat a missing variable like an unset clock instead: warn, keep the
> zero offset, and register the RTC. Reads expose the raw counter until
> the first clock set (typically the NTP-triggered RTC synchronization)
> computes the offset and creates the variable; from then on the machine
> keeps time across reboots. Userspace already copes with an implausible
> RTC value at boot -- systemd only steps the clock forward from its
> persistent timestamp.

No, this is a hack. And it, for example, prevents you from having the
RTC provide the same time in BIOS, Windows and Linux.

> Other read errors still fail the probe as before.
> 
> Verified on the Zenbook A16 across consecutive boots: on the first
> boot the driver warns, registers rtc0 and sets the system clock from
> the raw counter (1970-01-04 here -- the counter had been running for
> three days); the first NTP-triggered clock set creates RTCInfo; every
> following boot restores correct wall time from the RTC before any
> network is up.
> 
> Fixes: bba38b874886 ("rtc: pm8xxx: add support for uefi offset")

The current driver is not buggy, it's working as intended so there
should be no Fixes tag.

> Signed-off-by: Greg Ociepka <greg@ferrisoft.com>
> Assisted-by: Claude:fable-5
> ---
>  drivers/rtc/rtc-pm8xxx.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index e624f84..4627f4e 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -589,7 +589,21 @@ static int pm8xxx_rtc_probe_offset(struct pm8xxx_rtc *rtc_dd)
>  		rtc_dd->use_uefi = false;
>  	}
>  
> -	return pm8xxx_rtc_read_uefi_offset(rtc_dd);
> +	rc = pm8xxx_rtc_read_uefi_offset(rtc_dd);
> +	if (rc == -ENOENT) {
> +		/*
> +		 * The variable does not exist until something stores an
> +		 * offset: pm8xxx_rtc_write_uefi_offset() creates it on the
> +		 * first clock set. Keep probing with a zero offset instead
> +		 * of failing -- otherwise the RTC never registers and the
> +		 * variable can never come into existence.
> +		 */
> +		dev_warn(rtc_dd->dev,
> +			 "UEFI offset variable not found, will be created on first clock set\n");
> +		return 0;
> +	}
> +
> +	return rc;
>  }
>  
>  static int pm8xxx_rtc_probe(struct platform_device *pdev)

Johan

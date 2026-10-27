Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102002;
	b=Aa7Yl055eAubOrPbluQgmVxOMmHKOmXIq3/b0NQ2L3pB9o/yB/XCIMxDQDQqJAedCf5B
	 AxtGJb55DLQhMWxIObemQa3K5KheiPMj4a0wny9LoS0N8YPECgYb7QdTy/tUSWEpvb3me
	 uZUGSPptILgmn7RHVUjpSlNkWxpPsrU2autVXBo0DqMF9WjAzFac1fExTKQNcO+PO+PYZ
	 +z1BzcNleS3ov0FVYyDLvY1PJRVqxvms2hl3T7c5KmkB6gNXq4S9Q948eVwYBVXnQ4/ad
	 uSRZuAK3nul6h9vRGQ+D71sfTIrCb9Pd+eyb562fuW6bJMRVUHo9OZsUBmwIpFvxjbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102002;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eW571iO5qUDWhqnb/V2rwsfuoMvwgati36UAaHCNbvk=;
	b=EcOkIm5kmWqQVbrpjaD3t5TgFDM18S7Ay7Inq581PF9rzoFRMLT3Y5nF5qWXqQDbeocw
	 7LJv1TghmDkFrThc/h9dwJK0cuOpWgDfi3EcegA72GEUudX8t55znxSvW20IFUHLfhYkK
	 a5f0/MTGB8ahDcoMNjbY4q0N5l9nMDzSxAET9jNhGikDV+hSqidmovInE//TWHLmM91qE
	 vKMrr95hwQ5ntR+VaKavGrNZl1AhK38HEksRp9sZERA+wkyYAN1/3xVzai0avAbrMkhj0
	 Y3n+/Jufnx87Z8kKKutwOsw6za8nII6z6c5xOccVVAC11SdWka33M7S3oQKrmPCnMXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofM0RcTa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DC606A31D
	for <linux-rtc@vger.kernel.org>; Tue, 27 Oct 2026 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofM0RcTa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFC11F031E7
	for <linux-rtc@vger.kernel.org>; Tue, 27 Oct 2026 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793102001;
	bh=eW571iO5qUDWhqnb/V2rwsfuoMvwgati36UAaHCNbvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ofM0RcTa0CwBxEvlJOqowo/YO17DqYJ6necpPeND9VQ/86GbNxcpw1bdV1UY3kVqk
	 3bm6WhatvEfxQ2CF040xXt5MmkN8x/mNKjkglvn2VvWugS62o8f2Ks0miZTyk7Povl
	 o18DoyHmI5YPa808QCyTV3IGOvwCYplAiM1jPoEjb/gsPkxG/kpBsdr3lAitC/v79A
	 0CbrDv4pBbI/sPhtOcCLgknsXaDI7Xcrl42QtR9fYk4Fz2Vcxo94X/5Mh7XkO8Qreb
	 xU+Rnr9qCttHe5wqCJkOdJB4iPfaVw5onwlbHmft9bqN3Anf3sN0awKg0sC2TM3mI7
	 HCfdX/68S4Mew==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be4fea434bso686768e87.1
        for <linux-rtc@vger.kernel.org>; Tue, 27 Oct 2026 04:53:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzkLSDnDvNZkRbnUx0Eh/7mk0DpA+ahBMcc6fKbYZeLgugQF48GNRoro2OSP+K9qEsatEvmWJW+iMI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYF2mPoZH0BHWKcLrhzECEu2wizUqjmBU+WFB0N0uG07c4DaGY
	ubDLJXXD+mE2Zkm0qIltZsO+eekoMGUOob8a4cxN7NnBXwYlvctYPC4ymuyxxdE0dCrv79JAcDm
	+oDkpUTvV/AuPHkrPZ/7HRBXOWPgXytU=
X-Received: by 2002:a05:6512:318d:b0:5bf:c79d:68f with SMTP id
 2adb3069b0e04-5bfc79d06f3mr475833e87.2.1793102000095; Tue, 27 Oct 2026
 04:53:20 -0700 (PDT)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 27 Oct 2026 12:53:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g0B7HC5SV_VpBNnS0UffJn8w9_gsXpATkYhHFOBkAasg@mail.gmail.com>
X-Gm-Features: AclHuK-sPybzziVNvnjpKHMy_0ZM8EP9Kiy6CfDmwTeb6pCFjhVTy3qaKz6xdf8
Message-ID: <CAJZ5v0g0B7HC5SV_VpBNnS0UffJn8w9_gsXpATkYhHFOBkAasg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: TAD: introduce acpi_has_rtc()
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-acpi@vger.kernel.org, linux-rtc@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 4:21=E2=80=AFPM Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> The same RTC may also be accessible by other means, like the EFI
> GetTime() and SetTime() runtime services used by rtc-efi, which are best
> avoided if there is a native ACPI interface to the RTC.
>
> To allow other RTC drivers to stand down in that case, add an exported
> helper, acpi_has_rtc(), that returns true if there is a TAD the driver
> will register an RTC class device for.
>
> The helper looks for a platform device matching the driver's ID table
> whose _GCP indicates real time support, like acpi_tad_probe() checks,
> instead of checking whether the driver has bound to such a device, so
> that callers need not depend on the order in which drivers are probed.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v1: https://lore.kernel.org/r/20261022211304.2285792-1-hamzamahfooz@linux=
.microsoft.com/
> v2:
> - Rename acpi_tad_rtc_available() to acpi_has_rtc(), move it to within
>   acpi-tad (which allows us to simplify it quite a bit) and declare it
>   in linux/acpi.h. (Ard)
> - Add acpi_disabled check. (Ard)
> ---
>  drivers/acpi/acpi_tad.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h    |  6 ++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index 45459a4ca..eea4d2123 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -899,6 +899,44 @@ static const struct acpi_device_id acpi_tad_ids[] =
=3D {
>         {}
>  };
>
> +static int acpi_tad_rtc_match(struct device *dev, const void *data)
> +{
> +       unsigned long long caps;
> +       acpi_status status;
> +
> +       if (!acpi_match_device(acpi_tad_ids, dev))
> +               return 0;
> +
> +       status =3D acpi_evaluate_integer(ACPI_HANDLE(dev), "_GCP", NULL, =
&caps);
> +
> +       return ACPI_SUCCESS(status) && (caps & ACPI_TAD_RT);
> +}
> +
> +/**
> + * acpi_has_rtc - Check if the RTC should be driven via the ACPI TAD
> + *
> + * Check if there is a TAD implementing the real time methods that this =
driver
> + * will register an RTC class device for.
> + *
> + * Return: %true if the RTC should be driven via the ACPI TAD, %false ot=
herwise.
> + */
> +bool acpi_has_rtc(void)
> +{
> +       struct device *dev;
> +
> +       if (acpi_disabled || !IS_ENABLED(CONFIG_RTC_CLASS))
> +               return false;

You may as well put these new functions under the existing
CONFIG_RTC_CLASS #ifdef so they don't get compiled unnecessarily, and
add an empty stub for acpi_has_rtc() in the !CONFIG_RTC_CLASS case.

The IS_ENABLED(CONFIG_RTC_CLASS) check above will not be necessary any
more then.

Apart from the above, the patch looks fine to me.

> +
> +       dev =3D bus_find_device(&platform_bus_type, NULL, NULL,
> +                             acpi_tad_rtc_match);
> +       if (!dev)
> +               return false;
> +
> +       put_device(dev);
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(acpi_has_rtc);
> +
>  static struct platform_driver acpi_tad_driver =3D {
>         .driver =3D {
>                 .name =3D "acpi-tad",
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ddacac812..71524a821 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1553,6 +1553,12 @@ extern bool acpi_has_watchdog(void);
>  static inline bool acpi_has_watchdog(void) { return false; }
>  #endif
>
> +#if IS_REACHABLE(CONFIG_ACPI_TAD)
> +bool acpi_has_rtc(void);
> +#else
> +static inline bool acpi_has_rtc(void) { return false; }
> +#endif
> +
>  #ifdef CONFIG_ACPI_SPCR_TABLE
>  extern bool qdf2400_e44_present;
>  int acpi_parse_spcr(bool enable_earlycon, bool enable_console);
> --
> 2.56.0
>

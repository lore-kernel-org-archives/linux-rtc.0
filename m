Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4C355F41
	for <linux-rtc@vger.kernel.org>; Sun, 28 Jun 2026 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782661300; cv=pass; b=j7kLZZEPo5jy6MCRBmxjBlUJ+/vllC86YTRliIOZZ2CnGBK6gWfp9871FGb9upQlTyx0sGNE8tK4uYBQ/j1/5LFYgiu8L6kT1i9KP2ewTvyRrXZ9+fFmyXSOGlHz0t98UePONXHqoNSrH70o4rZWhmkmQC+xEHfAJyC7ZiBk9iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782661300; c=relaxed/simple;
	bh=cnPIYVAMv3ieeHKwZpbJSHxnvhow3LpnE6CSpQeDK/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsNQpKRvv4QusiqEn+8H448OHnV57HNDIiLrLxW5AVgKPvvbxkZXOWi9HycHof/+yG8QOF0ZIuHfiQCzUvFeGtYOEBt4DWbPqpexA7Qs1BKjCn0c6yshzeNs8qkXU8VA72vrIbXFFRJOpmt2xcWi1T+3r3VHl5rcVeloKwQnOuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWZU9pQ/; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWZU9pQ/"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c125bcfd9a1so37751366b.1
        for <linux-rtc@vger.kernel.org>; Sun, 28 Jun 2026 08:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782661298; cv=none;
        d=google.com; s=arc-20260327;
        b=d1ZaH8M7O8cueVxye8F2gYo28QENjvTPoFCCtz7X8T9rhbJEmB/ajNqhMusvhfbNCd
         eVQyBMMNkNoJJMKVac3dqrhINnyCLVwlC5zxsz8VX2JxxnhCdtzApStgV1YtbECiVp4M
         JR353mh0cQEmdwkHwWomJ1XV0S49QoZak3bLYIfl6SDcumJIAJ8mhsTP8qrzcRG9fSgz
         yCrIgSPliwDjU3VWvO5ruSBH3lqRTN9bVZ+KFXgUy137GMYsue/XuLPviEtldUpb6l0h
         wVyvsRu8v/Kkk10U6jDwRZsPoNZZ5I+Ha0ffmqSPcwOlzk3Zadn9LIAEbSROU+R96ap5
         RFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gVwxX6oJJElFHQ2ORAdkJDrNcRx+IjNqMgah8jhTmDw=;
        fh=BADxx7cfZMAIpmLkRFSaMPqDjwO87IH1RFAwvfjiaGA=;
        b=KTYivl1U2EzOoLeNLkl2yL+F2UWw/u3046z0C4DZe/pZ2RMGSf206LqgwHyVm6TyVJ
         Q+4t4I5LkNAP1DvE5YIBce7U1aPdq/2tdnlHcsjo6blNWdk/Y0r/cIobqffpWz5r7C9o
         NtazwhQ9/+qd5rp58Zl7I1NQhdK8i5Fqxdw4a3z7tojPfqkmukNd57WOcusD7ZLlZ+3+
         tl2o5GJt0YozoReP9Z1ANztCdGypl2nBhSipIpDuB7Jf7suD4A4TaFn8KqU99eTcbI5f
         1yG8X5nRTboxZJEcK7PAIbAC0Je5KAN3nt7mgVjRWszLyvVjzRPjfqbqPMxZt/5mQZzs
         hL4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782661298; x=1783266098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gVwxX6oJJElFHQ2ORAdkJDrNcRx+IjNqMgah8jhTmDw=;
        b=GWZU9pQ/vI9UiSn1KSppFHe5ifQg9hDH/OOylb2Pa7LfXP4BQVpSdS/y500+QVBzH8
         t5nVdrXzmQgXZTGIDZqdHbZW3886patayoZLL2D8s0w8Ke5yndd/tP1UkW6dp+H+Z9aA
         3ceghQJbRV6vhB8NyROHvgjPc2PUfZ632BlmypXPAZA5rpiQuC8nxNsnHeHXo0LExwiu
         mvpCcdAL4La+ApluCflbsAYPKqMSr4oXlPYg99qTR3EEtD3G5U8zQV1zofzVO4LV6iKa
         K39HN7OsBHZgllaEUJaEM8hFaMFO59dlnsioQgfHCszC8Numm+a7CVvzwiHWkXU+XXTG
         pOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782661298; x=1783266098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVwxX6oJJElFHQ2ORAdkJDrNcRx+IjNqMgah8jhTmDw=;
        b=P6XZf4v9YIZMQdYN/paj8iKQOHT62TxR1mXv05wY0h0XhnI9JZSFn0NDfA/wxv1ylK
         J8yGx9HGDKuOrO48Pi3yJ2J/s2ZQoZ78Iu7f+hq5TZzKEgi9KfFZDTdvPW4HmdMcN3AM
         S9Nvhk8BQCI8QnoEZnoZlc00E5n9jGuSc2Qgpqe0YWm8TyjH8Lv7gtj/4AvutDRacfo/
         Nu2Fe308i87ugiVZAVk8fda6+nBcynszLf0DmvaT6jEQzzCSnJ9dcFnLqycY2u9S3gVm
         vFViqOz3Qud5NBmL3eJCQT9aQXsQQagz/EiMX5xczsX0Yxz2Xr8Fc6VwPLtkRCZtug8L
         m45Q==
X-Forwarded-Encrypted: i=1; AHgh+RrwRO1tBok4FIxFMKyBxnoK34lv29P4Mh+yo7e9+UqUMndQnTgEsjxQZiM/0zW7AnB4SJw75n7LGoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR40m6XqBZ8LqoT6Qem1gGzO1vAYvXT8DoiCyIWArHAmbcagtx
	7uuHDSRqxMHp9iRx9PctW43BE/meXPV3Kx4X4xfWDQ62lDUGS9MQzExbO0NC2u7xn9nuh1WsgT2
	M5nxQD/Zc3BfvY2Jbiex77zzWvGuQ2yo=
X-Gm-Gg: AfdE7cnpTqOACX3h/EOMBFsimHvaD8FIlP3bDtroxIITiJgJLnJbrTvBgJAThR67nZu
	QOuMqHxfkhlIcT81GOSce6M6Yq/2NG+cV03j7aAFOoBfseOjFBiUjVqU3DlQH03Ehc2yctESlcr
	1bu7Re2Z6tdLeiTqh8PI+dqbCbCg1WY8qmXxJA5QshgNgxw0psNlwA586ih8Y1sUB3pwCdCTLeJ
	4AYNeW7Bx3QKAJWa6ODLNmlM+cAwIXs7eE+pN7GY3/NIDJEojY7a1H2JPvrvMy2pnwMxK3jSh1S
	1qXZvP4=
X-Received: by 2002:a17:906:f585:b0:c12:696b:dd8c with SMTP id
 a640c23a62f3a-c12696be22bmr29316066b.49.1782661297435; Sun, 28 Jun 2026
 08:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601194615.1979101-1-dbgh9129@gmail.com> <178252038524.1704966.578320083174571195.b4-review@b4>
In-Reply-To: <178252038524.1704966.578320083174571195.b4-review@b4>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Sun, 28 Jun 2026 11:41:26 -0400
X-Gm-Features: AVVi8Cdoe-spPF9QMTFfw8UHDPDkF3-VWHXXLtvE1aSAkWTjwFaOCDIBfL6d0VE
Message-ID: <CACrCO_XEfKv9Nk2tEh_i778RYcDUk6sTuU6Uf__ZsPRejkRsTQ@mail.gmail.com>
Subject: Re: [PATCH v1] rtc: m41t80: clean up watchdog on probe failure
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 20:33, Alexandre Mergnat <amergnat@baylibre.com> wrote:
> IMHO the right fix is to move the watchdog to the watchdog core.
>
> The leak comes from the watchdog being built on three non-devres
> save_client. A probe failure strands all three, after which the watchdog
> dereferences freed driver state (wdt_ping() reads
> i2c_get_clientdata(save_client), i.e. the devres-freed m41t80_data).
>
> Built on the watchdog core (CONFIG_WATCHDOG_CORE), none of that
> machinery is needed:
>
> - devm_watchdog_register_device() unregisters automatically on any probe
>   failure and on unbind.
> - watchdog_stop_on_reboot() replaces the reboot notifier.
> - watchdog_set/get_drvdata() replaces the global save_client, closing
>   the use-after-free surface itself.
> - m41t80_remove() does nothing but watchdog teardown today, so it goes
>   away too.
>
> This is exactly what was done for the sibling driver rtc-ds1374, which
> carried the same legacy pattern: d3de4beb14a8 ("rtc: ds1374: wdt: Use
> watchdog core for watchdog part"), net -135 lines, adding "select
> WATCHDOG_CORE" in Kconfig. It is a usable template.
>
> primitives: a misc device, a reboot notifier, and the global

Thanks for the detailed suggestion, Alexandre.

Moving to the watchdog core sounds like a better approach. I will
rework this based on the rtc-ds1374 example and send v2.

Thanks,
Yuho

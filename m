Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795097293;
	b=J91UP7HsMFJNtxU3RWy+ZZ+jcTVfMpKqtGNXgXX2Oxi2Lh+geHh/fftrp70n8G7A4IQi
	 jk5Nn8h1n9aB9vU9DL+NYLdG1QFgAiZZalW0ylBeXvuN6WMecU4Id9dl3SlNtMOUu4Em4
	 vgRYGLFZTqBsqHnV+cKhV+9vgNCU5RDpIz0JVfg5on7mrAtNjhuzLJdNfJk61DHnFf9Oj
	 9IVOG8zK60ElJmDaoq3KuLLi/eEWm3gy4UfqFUh53hWeVZ9tOl18P55+hbWWCcapgdiPr
	 k+7Ifb98CYjirpckQlVIwfieivAbqEaRykIWYiYkhUe1fFA+Ra3/rE2RsfIk5CzqW0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SAtgjovQGOJhJVDA6kWd6ptbxhHXvNBnvWsIVbDqIls=;
	b=omCm0m2bXuyW/DMhbsjnYSJ5MoWXp/bklEmIpFQhqCj1bMrxvaIVDfsz0C8zOfZv9j8U
	 1cy6464W9kBpPoQJqEsQaXUv/J6VrqSugs+xnZhW1Daet1kQxOKq1bKkVDYQWsUkmi4hW
	 zQTTEpbsrEWVsj9+G7n5I4ULJequxodJJVYIH5Sz5ntmODsQOpV4zzj5rGvCJXY4GHUnx
	 6tVqW+4ZWZmhwuxQ73I7YnEOrPgMoqaz/b6hnxeFLZELdFJLsESt6sh4+FjUz4pngonFV
	 ADXxTnKldz3VfGraHlRoLMkKIO0KStN7eRTxHrh7cDiDA11DtVdunbG6qbzVzLDc4JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SORAkYSK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B38606A326
	for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 14:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66B38606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SORAkYSK
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so565663eec.0
        for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 06:08:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795097292; cv=none;
        d=google.com; s=arc-20260327;
        b=LnpKl8nhNGFzXoo59InTi7VG93q3OLc5ZmiS1cir/aWu57J9lQ3uG9D3XluoAYSLC/
         w9QfVLub9jWbwgICcMyWWrM7bpzjuwv9PefC0S+KHpcWSZPfX8rlpnHgGhbHx2TFZaTL
         skxIC3BVhzjAwtEC7mEVYmoTua/t50dUyeigqs6/4wN+eXmJg0ZotdIVDTlnNA6ZAU08
         2pMBvcJn7CziZM/4yF+o06Cf7gqdgZHKz2UUq1IViGVCh/nAX8tmScsA+6CnhdE/4XPR
         QzW0zJ63fBTAvx7f6xeoUj/GtJYgoNIhE7Cj773gPETPWEQOLX1FfKkvsgjGSovjjCim
         AEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SAtgjovQGOJhJVDA6kWd6ptbxhHXvNBnvWsIVbDqIls=;
        fh=0VOhN8kAdKHtjHbSZnDoKYGoYtk/V8AMwQUK+iwwYPA=;
        b=GQtewfZCwYrN2Mi2l8mRJAXkksjTv1XI9NJb9ndhWTjp8i8nYpuITxzu9HEhMBgoxP
         7hJZb/C7QCIGUMY/0wIlZdBUSbtvPDRyXHwBVPOwM/S7cpSsmujjmXWGHBbZTi2om40X
         0IoxUL5LadA/AgKHLxo1v/Ej/1qB/i+HiDvQ8spkDe7PAHiR3I/gbNiKrIVMyamMrjhI
         M7OkyiCNN0FROw1kbVqwKLfa4hIoNTERCxPbNbuGov/bralN9Ak1PWe6hx0uHIyrU+nq
         aY40/Eajp1jWl3NTZXevuePvBkuQsDSYI1RfMNHig7rCFi9Rigw6RqMAd7Nhcrfe78ta
         aklQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795097292; x=1795702092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SAtgjovQGOJhJVDA6kWd6ptbxhHXvNBnvWsIVbDqIls=;
        b=SORAkYSKCiBsVUrC6wYAux2lJSLp9amBQwqx5skGYkiwTFG2WZXVtaOUfuh3riWI0U
         xBMC+ktwOrCoH8FRmgPw51MHlQKW+tgeA/LHkkZdch7xpVtF44L4da4KEjEoM1AMRDSy
         pOIXtEQRBw0xULgMlHho/ySW1f+OsK0ZQGdNRQ9fZ8SzDdQvyc6aqpPlMU3f9UXKNR9N
         0+17NquvtilCFrEF2VERzhV5vSOxbI4TU/9+q0FNcD7ANZiJphEQfrGci7OqhtuDxe21
         dTgOmlQbAz017QaLMCgeIkkq/g23I4xvGGdgaIIQgUV074Qoh0rzPCC+XyukoLXrFilQ
         YYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795097292; x=1795702092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SAtgjovQGOJhJVDA6kWd6ptbxhHXvNBnvWsIVbDqIls=;
        b=zp1fvuEALgb3fftY1r0eJhIpT3+S3k5NtyJ2LZYWr2npsqXNZTAFtxjdphQ35CFxpN
         p853PBHH+O21rgC4xn0yKH2oB8RmNg8gh7WNZU09cwkZFQ4HKQaX4s+gPhDrxIh8ozih
         UIVsy4aq6HrjDnDQOkd9lqNcW3H4kObU48H6QuOg00m/a66sUMCYKd4e14MT6ixYDWEo
         GLbdqKL3/M0VJgWl35mt466uLxwUBL3O4dd0FRY6/kPeBC+zTyGiLJaalZ7lQCXwxnV7
         XpwmNOe3K8XG2aQu4maFFxCj7y1hkuB2MxcXarm3F0YsftQ6zcoM1YzxlalSGIegRNAc
         5aBg==
X-Forwarded-Encrypted: i=1; AL+hErEV4kZIe5n5AdtB1EvQwgfreXeNwJlRCoJBgYLvj6sS73JlBpU+ihXqmv1ex/G/UKBKEXFkVjbd238=@vger.kernel.org
X-Gm-Message-State: APuU4Z8z9K6a/MgRJV4XQkgiMtOfGVI4L5zDULiX2ZNimw5o6abmASAY
	TBH3ziM1CLSPNBxZJvhTpqSrojYopFl/t4k/mwlB0G2L0MfiJwIVNSvqSDUuhyTNkgX3Q32JFPu
	TCzxuVC+1arKJNm93mPunH/AeN+l7XXsYWUFKPoskBp1pm5D0fg==
X-Gm-Gg: AZFdTZdob1E8BywpjkG54pWMSdUtIN7rjXUqamKev8vFWPoq5k3t/7DQ5OHYzkLwte9
	IzDAR9zpdp3NSSqpNEhkdWImsyYTRX1twjPZ5u1oHY/UC6ANBVXVz2ipUO9sq3RUTOJFUVhy7xB
	9Qkimw+K2qyi4WMg4TeAhBtPon8d5MdANhbjeYxlRcNb4mK7lzJKy4hk1basLEIRTleN9R9fB3i
	bAplQbqm4T4I7cbSPHSvl4sbtyEX8x1fpK8MTs8lL43Tqel5ECqnVYMLh2LG+9F8oCKPyClQJ4c
	zwgbZCXySyDi0RRO5UpzUe9vWpkGKiKsBTz/pb0E93ByV9bmmeFTv7t7C3Zv1NZU71A0OCYKLW0
	hl3y5psITdIHzAuuV7+gyPGHDDMu7HXjhslrgMw==
X-Received: by 2002:a05:693c:20c5:10b0:376:e950:873e with SMTP id
 5a478bee46e88-3827f98b78bmr5050359eec.12.1795097292380; Thu, 19 Nov 2026
 06:08:12 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119125125.75912-1-pengjunhao409@gmail.com> <7e207fea-8aae-4271-9e94-331464442ae9@kernel.org>
In-Reply-To: <7e207fea-8aae-4271-9e94-331464442ae9@kernel.org>
From: bill Smith <pengjunhao409@gmail.com>
Date: Thu, 19 Nov 2026 22:07:57 +0800
X-Gm-Features: Aa3M54qmdi0dWKA475ui43FuP9edDKAvcfBsoIojmaQTyA24HpB57Hb-KN3eZxo
Message-ID: <CALbS5L1moAiDADSoFrXruB6jdendFpwcyjQNb=OV0MTQeuYEiw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: rtc: haoyu,hym8563: document vdd-supply
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:20=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> "The submitter"? So LLM wrote it for the "submitter" and you just
> blindly send it :/
Sorry for the noise. I re-read submitting-patches.rst and the DCO
section.

For v4 I will write the commit message myself, describing only the
hardware rationale, move the AI disclosure below the --- line, and drop
the version links. There are no code changes. I will send it tomorrow.

Best regards,
pjh456

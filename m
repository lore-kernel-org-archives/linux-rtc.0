Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9F7081E;
	Fri, 14 Aug 2026 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668450; cv=none; b=WpUG3KDcQHvk/O3OBDeQtuhyCsIBLZuw+0nNuN46514yHq9PSyyjmkNMmEHgZJ4q43f2O8RtKu8AsjQXHE2e4BqmRQXEKCU5zm8SNn531I8pAGCjOMs2q9r0ea10/Kq/62zUlbCtroNdbJ/TF6l7qE1AJ9Ob9sILhvG3bOTVEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668450; c=relaxed/simple;
	bh=PiwnyOh2KZOc8kCGpr12Y0RLCLz4yF0E1ypVx7JAjnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M8madEnJ1DiFAg/XuZdAgIOcN6hylnDIuKsCtcbunWY+V3NfdmC87z59aAymmsCTSUsYORycQLHr0QX9mP08tc3qvMJc0QhgSq+2UTrGZTm+cpB0+hOpWklcW7PJfaqHg2kXymhosYU3ChL4tgTj2+VFfFDicK0rwZ3BI62UKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+295faG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+295faG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7981F000E9;
	Fri, 14 Aug 2026 00:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786668449;
	bh=PiwnyOh2KZOc8kCGpr12Y0RLCLz4yF0E1ypVx7JAjnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+295faGtD9xQAuhXAqPUfbHcYnZ3IwgpzuYvtAxxpXY2+MnZOewIODlwb3Oa9wBI
	 T/VJ0BzgZgRTW0st40xMqTnaeR06eR6kdSpIhrJq1J/M2YheEGopVV7iTZDjoiNPn2
	 AEcf3B3F3rqMr9TVcnM7C2g6CVQlekG4ABVmRXlOZbwQUkAxH6k2WEJRpkjal7DtsO
	 X+ho50RrH/qihadBXIFWZI6vet5BLhVNShc4yS4ezk4WCMe0SlFPHLh1QwZls5ipxk
	 YAjvgppa4xSzGcMJZ7jbXRzU2wOBnNRbLd7i3fZK1nYSPA/PqTjw4Ve/B5ChV5/lfE
	 dxUYAT1QOq8+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: rtc: abx80x: document ABX81X RTCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260810193826.210683-2-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
 <20260810193826.210683-2-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:47:24 +0000
Message-Id: <20260814004729.6F7981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Abracon AB0815 and AB1815 are RTC modules with SPI interface.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193826.2106=
83-1-apokusinski01@gmail.com?part=3D1

